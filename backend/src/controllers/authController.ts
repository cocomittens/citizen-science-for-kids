import { Request, Response } from "express";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { findUserByEmail, createUser } from "../db/userQueries";

const SALT_ROUNDS = 10;

// Register a new user
export const register = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  try {
    const existing = await findUserByEmail(email);

    if (existing) {
      return res.status(400).json({ error: "Email already in use" });
    }

    const passwordHash = await bcrypt.hash(password, SALT_ROUNDS);
    const teacher = await createUser(email, passwordHash);

    res.status(201).json({ id: teacher.id, email: teacher.email });
  } catch (err) {
    res.status(500).json({ error: "Registration failed" });
  }
};

// Log user in
export const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  try {
    const teacher = await findUserByEmail(email);

    if (!teacher) {
      return res.status(401).json({ error: "Invalid credentials" });
    }

    const valid = await bcrypt.compare(password, teacher.password_hash);

    if (!valid) {
      return res.status(401).json({ error: "Invalid credentials" });
    }

    // Create token for signed in user, expires after 7 days
    const token = jwt.sign(
      { id: teacher.id, email: teacher.email },
      process.env.JWT_SECRET as string,
      { expiresIn: "7d" },
    );

    res.json({ token });
  } catch (err) {
    res.status(500).json({ error: "Login failed" });
  }
};
