import { Response } from "express";
import { AuthRequest } from "../middleware/requireAuth";
import {
  createProject,
  getAllProjects,
  getProjectById,
  deleteProject,
  updateProject,
} from "../models/projectModel";

export const handleCreateProject = async (
  req: AuthRequest,
  res: Response,
): Promise<void> => {
  try {
    const { title, description } = req.body;

    if (!title || typeof title !== "string" || title.trim() === "") {
      res.status(400).json({ error: "title is required" });
      return;
    }

    const project = await createProject(req.teacher!.id, {
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

export const handleGetAllProjects = async (
  req: AuthRequest,
  res: Response,
): Promise<void> => {
  try {
    const projects = await getAllProjects(req.teacher!.id);
    res.json(projects);
  } catch (err) {
    console.error("Failed to fetch projects:", {
      teacherId: req.teacher?.id,
      err,
    });
    res.status(500).json({ error: "Failed to fetch projects" });
  }
};

export const handleGetProjectById = async (
  req: AuthRequest,
  res: Response,
): Promise<void> => {
  try {
    const project = await getProjectById(
      req.params.id as string,
      req.teacher!.id,
    );
    if (!project) {
      res.status(404).json({ error: "Project not found" });
      return;
    }
    res.json(project);
  } catch (err) {
    console.error("Failed to fetch project:", {
      teacherId: req.teacher?.id,
      projectId: req.params.id,
      err,
    });
    res.status(500).json({ error: "Failed to fetch project" });
  }
};

export const handleDeleteProject = async (
  req: AuthRequest,
  res: Response,
): Promise<void> => {
  try {
    const deleted = await deleteProject(
      req.params.id as string,
      req.teacher!.id,
    );
    if (!deleted) {
      res.status(404).json({ error: "Project not found" });
      return;
    }
    res.status(204).send();
  } catch (err) {
    console.error("Failed to delete project:", {
      teacherId: req.teacher?.id,
      projectId: req.params.id,
      err,
    });
    res.status(500).json({ error: "Failed to delete project" });
  }
};

export const handleUpdateProject = async (
  req: AuthRequest,
  res: Response,
): Promise<void> => {
  try {
    const { title, description } = req.body;

    if (
      title !== undefined &&
      (typeof title !== "string" || title.trim() === "")
    ) {
      res.status(400).json({ error: "title cannot be empty" });
      return;
    }

    const project = await updateProject(
      req.params.id as string,
      req.teacher!.id,
      {
        title: title?.trim(),
        description: description?.trim(),
      },
    );

    if (!project) {
      res.status(404).json({ error: "Project not found" });
      return;
    }

    res.json(project);
  } catch (err) {
    console.error("Failed to update project:", {
      teacherId: req.teacher?.id,
      projectId: req.params.id,
      err,
    });

    res.status(500).json({ error: "Failed to update project" });
  }
};
