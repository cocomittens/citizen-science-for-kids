import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";

// Extends Express Request to include authenticated teacher data
export interface AuthRequest extends Request {
  teacher?: { id: string; email: string };
}

// Protects routes that require authentication
export const requireAuth = (
  req: AuthRequest,
  res: Response,
  next: NextFunction,
) => {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    console.log(`Unauthenticated request to ${req.path}`);
    return res.status(401).json({ error: "No token provided" });
  }

  const token = authHeader.split(" ")[1];

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET as string) as {
      id: string;
      email: string;
    };
    req.teacher = decoded;
    next();
  } catch (err) {
    console.log(`Invalid or expired token for ${req.path}:`, err);
    res.status(401).json({ error: "Invalid or expired token" });
  }
};
