import { Request, Response } from "express";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { findUserByEmail, createUser } from "../db/userQueries";

const SALT_ROUNDS = 10;

// Helper function to validate email/password inputs
const validateCredentials = (
  email: string,
  password: string,
  res: Response,
): boolean => {
  if (!email || !password) {
    res.status(400).json({ error: "Email and password are required" });
    return false;
  }
  return true;
};

// Register a new user
export const register = async (req: Request, res: Response) => {
  const { email, password } = req.body;
  if (!validateCredentials(email, password, res)) return;

  try {
    const existing = await findUserByEmail(email);

    if (existing) {
      console.log(`Registration attempt with an existing email: ${email}`);
      return res.status(400).json({ error: "Email already in use" });
    }

    const passwordHash = await bcrypt.hash(password, SALT_ROUNDS);
    const teacher = await createUser(email, passwordHash);

    console.log(
      `New user successfully registered: ${teacher.email} (id: ${teacher.id})`,
    );
    res.status(201).json({ id: teacher.id, email: teacher.email });
  } catch (err) {
    console.error(`Registration error for ${email}:`, err);
    res.status(500).json({ error: "Registration failed" });
  }
};

// Log user in
export const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;
  if (!validateCredentials(email, password, res)) return;

  try {
    const teacher = await findUserByEmail(email);

    if (!teacher) {
      console.log(`Login attempt for unknown email: ${email}`);
      return res.status(401).json({ error: "Invalid credentials" });
    }

    const valid = await bcrypt.compare(password, teacher.password_hash);

    if (!valid) {
      console.log(`Failed login attempt for: ${email}`);
      return res.status(401).json({ error: "Invalid credentials" });
    }

    // Create token for signed in user, expires after 7 days
    const token = jwt.sign(
      { id: teacher.id, email: teacher.email },
      process.env.JWT_SECRET as string,
      { expiresIn: "7d" },
    );

    console.log(`User logged in: ${teacher.email} (id: ${teacher.id})`);
    res.json({ token });
  } catch (err) {
    console.error(`Login error for ${email}:`, err);
    res.status(500).json({ error: "Login failed" });
  }
};
