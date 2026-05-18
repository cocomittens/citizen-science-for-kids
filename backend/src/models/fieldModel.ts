import pool from "../db";

export interface Field {
  id: string;
  project_id: string;
  label: string;
  field_type: string;
  options?: string;
}

export interface CreateFieldInput {
  label: string;
  field_type: string;
  options?: string;
}

export const getFieldsByProjectId = async (
  projectId: string,
  teacherId: string,
): Promise<Field[]> => {
  const result = await pool.query(
    `SELECT f.* FROM fields f
     JOIN projects p ON p.id = f.project_id
     WHERE f.project_id = $1 AND p.teacher_id = $2
     ORDER BY f.id ASC`,
    [projectId, teacherId],
  );
  return result.rows;
};

export const createField = async (
  projectId: string,
  teacherId: string,
  input: CreateFieldInput,
): Promise<Field | null> => {
  // Verify that the project belongs to this specific teacher
  const projectCheck = await pool.query(
    `SELECT id FROM projects WHERE id = $1 AND teacher_id = $2`,
    [projectId, teacherId],
  );
  if (projectCheck.rows.length === 0) return null;

  const result = await pool.query(
    `INSERT INTO fields (project_id, label, field_type, options)
     VALUES ($1, $2, $3, $4)
     RETURNING *`,
    [projectId, input.label, input.field_type, input.options ?? null],
  );
  return result.rows[0];
};
