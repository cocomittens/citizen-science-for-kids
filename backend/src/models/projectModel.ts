import pool from "../db";

export interface Project {
  id: string;
  teacher_id: string;
  title: string;
  description?: string;
  class_code: string;
}

export interface CreateProjectInput {
  title: string;
  description?: string;
}

// Generate random class code in format ABC-1234
const generateClassCode = (): string => {
  const letters = Math.random().toString(36).substring(2, 5).toUpperCase();
  const numbers = Math.floor(1000 + Math.random() * 9000);
  return `${letters}-${numbers}`;
};

export const createProject = async (
  teacherId: string,
  input: CreateProjectInput,
): Promise<Project> => {
  const classCode = generateClassCode();
  const result = await pool.query(
    `INSERT INTO projects (teacher_id, title, description, class_code)
     VALUES ($1, $2, $3, $4)
     RETURNING *`,
    [teacherId, input.title, input.description ?? null, classCode],
  );
  return result.rows[0];
};

export const getAllProjects = async (teacherId: string): Promise<Project[]> => {
  const result = await pool.query(
    `SELECT * FROM projects WHERE teacher_id = $1 ORDER BY title ASC`,
    [teacherId],
  );
  return result.rows;
};
