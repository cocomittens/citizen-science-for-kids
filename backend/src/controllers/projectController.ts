import { Request, Response } from "express";
import { AuthRequest } from "../middleware/requireAuth";
import {
  getAllProjects,
  getProjectById,
  getProjectByClassCode,
  createProject,
  updateProject,
  deleteProject,
} from "../models/projectModel";
import { getObservationsByProjectId } from "../models/observationModel";

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
  req: Request,
  res: Response,
): Promise<void> => {
  try {
    const project = await getProjectById(req.params.id as string);
    if (!project) {
      res.status(404).json({ error: "Project not found" });
      return;
    }
    res.json(project);
  } catch (err) {
    console.error("Failed to fetch project:", {
      projectId: req.params.id,
      err,
    });
    res.status(500).json({ error: "Failed to fetch project" });
  }
};

export const handleGetProjectByClassCode = async (
  req: AuthRequest,
  res: Response,
): Promise<void> => {
  try {
    const project = await getProjectByClassCode(req.params.classCode as string);

    if (!project) {
      res.status(404).json({ error: "Project not found" });
      return;
    }

    res.json(project);
  } catch (err) {
    console.error("Failed to get project by class code:", {
      classCode: req.params.classCode,
      err,
    });

    res.status(500).json({ error: "Failed to fetch project" });
  }
};

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

export const handleExportProjectCSV = async (
  req: Request,
  res: Response,
): Promise<void> => {
  try {
    const observations = await getObservationsByProjectId(
      req.params.id as string,
    );

    if (observations.length === 0) {
      res.status(200).send("No observations found");
      return;
    }

    const fieldLabels = observations[0].values.map((v: any) => v.label);
    const header = ["student_name", "observed_at", ...fieldLabels].join(",");

    const csvRows = observations.map((obs) =>
      [
        obs.student_name ?? "",
        obs.observed_at,
        ...fieldLabels.map((label) => {
          const match = (obs.values as any[]).find((v) => v.label === label);
          return match?.value ?? "";
        }),
      ].join(","),
    );

    res.setHeader("Content-Type", "text/csv");
    res.setHeader(
      "Content-Disposition",
      `attachment; filename="project_${req.params.id}.csv"`,
    );
    res.send([header, ...csvRows].join("\n"));
  } catch (err) {
    if ((err as Error).message === "PROJECT_NOT_FOUND") {
      res.status(404).json({ error: "Project not found" });
      return;
    }
    res.status(500).json({ error: "Failed to export CSV" });
  }
};
