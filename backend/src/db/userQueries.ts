import pool from "./index";
import { Teacher } from "../models/user";

// Find existing teacher via email
export const findUserByEmail = async (
  email: string,
): Promise<Teacher | null> => {
  const result = await pool.query("SELECT * FROM teachers WHERE email = $1", [
    email,
  ]);
  return result.rows[0] || null;
};

// Create a new teacher
export const createUser = async (
  email: string,
  passwordHash: string,
): Promise<Teacher> => {
  const result = await pool.query(
    "INSERT INTO teachers (email, password_hash) VALUES ($1, $2) RETURNING *",
    [email, passwordHash],
  );
  return result.rows[0];
};
