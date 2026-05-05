import { Response } from "express";
import { AuthRequest } from "../middleware/requireAuth";
import { createProject } from "../models/projectModel";

export const handleCreateProject = async (
  req: AuthRequest,
  res: Response,
): Promise<void> => {
  try {
    const { title, description } = req.body;

    if (!req.teacher) {
      res.status(401).json({ error: "Unauthorized" });
      return;
    }

    if (!title || typeof title !== "string" || title.trim() === "") {
      res.status(400).json({ error: "title is required" });
      return;
    }

    const project = await createProject(req.teacher.id, {
      title: title.trim(),
      description: description?.trim(),
    });

    res.status(201).json(project);
  } catch (err) {
    console.error("Failed to create project:", {
      teacherId: req.teacher?.id,
      err,
    });
    res.status(500).json({ error: "Failed to create project" });
  }
};
