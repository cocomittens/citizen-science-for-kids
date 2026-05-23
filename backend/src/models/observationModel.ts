import pool from "../db";

export interface Observation {
  id: string;
  project_id: string;
  student_name?: string;
  observed_at: string;
}

export interface ObservationValue {
  field_id: string;
  value: string;
}

export interface ObservationWithValues extends Observation {
  values: ObservationValue[];
}

export interface CreateObservationInput {
  id: string;
  student_name?: string;
  values: ObservationValue[];
}

export interface UpdateObservationInput {
  student_name?: string;
  values: ObservationValue[];
}

export const getObservationsByProjectId = async (
  projectId: string,
): Promise<ObservationWithValues[]> => {
  // Verify project exists
  const projectCheck = await pool.query(
    `SELECT id FROM projects WHERE id = $1`,
    [projectId],
  );

  if (projectCheck.rows.length === 0) throw new Error("PROJECT_NOT_FOUND");

  const observations = await pool.query(
    `SELECT * FROM observations WHERE project_id = $1 ORDER BY observed_at DESC`,
    [projectId],
  );

  if (observations.rows.length === 0) return [];

  const observationIds = observations.rows.map((o) => o.id);
  const valuesResult = await pool.query(
    `SELECT * FROM observation_values WHERE observation_id = ANY($1)`,
    [observationIds],
  );

  return observations.rows.map((obs) => ({
    ...obs,
    values: valuesResult.rows.filter((v) => v.observation_id === obs.id),
  }));
};

export const createObservation = async (
  projectId: string,
  input: CreateObservationInput,
): Promise<ObservationWithValues> => {
  const obsResult = await pool.query(
    `INSERT INTO observations (id, project_id, student_name)
     VALUES ($1, $2, $3)
     RETURNING *`,
    [input.id, projectId, input.student_name ?? null],
  );

  const observation = obsResult.rows[0];

  if (input.values.length === 0) {
    return { ...observation, values: [] };
  }

  const valueRows = await Promise.all(
    input.values.map((v) =>
      pool.query(
        `INSERT INTO observation_values (observation_id, field_id, value)
         VALUES ($1, $2, $3)
         RETURNING *`,
        [observation.id, v.field_id, v.value],
      ),
    ),
  );

  return {
    ...observation,
    values: valueRows.map((r) => r.rows[0]),
  };
};

export const updateObservation = async (
  observationId: string,
  input: UpdateObservationInput,
): Promise<ObservationWithValues | null> => {
  const obsResult = await pool.query(
    `UPDATE observations
     SET student_name = $1
     WHERE id = $2
     RETURNING *`,
    [input.student_name ?? null, observationId],
  );

  if (obsResult.rows.length === 0) return null;

  const observation = obsResult.rows[0];

  // Delete existing values in DB and insert new
  await pool.query(`DELETE FROM observation_values WHERE observation_id = $1`, [
    observationId,
  ]);

  if (input.values.length === 0) {
    return { ...observation, values: [] };
  }

  const valueRows = await Promise.all(
    input.values.map((v) =>
      pool.query(
        `INSERT INTO observation_values (observation_id, field_id, value)
         VALUES ($1, $2, $3)
         RETURNING *`,
        [observation.id, v.field_id, v.value],
      ),
    ),
  );

  return {
    ...observation,
    values: valueRows.map((r) => r.rows[0]),
  };
};
