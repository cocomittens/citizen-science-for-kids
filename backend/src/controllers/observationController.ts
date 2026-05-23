import { Request, Response } from "express";
import { AuthRequest } from "../middleware/requireAuth";
import {
  getObservationsByProjectId,
  createObservation,
} from "../models/observationModel";

export const handleGetObservations = async (
  req: Request,
  res: Response,
): Promise<void> => {
  try {
    const observations = await getObservationsByProjectId(
      req.params.id as string,
    );

    res.json(observations);
  } catch (err) {
    if ((err as Error).message === "PROJECT_NOT_FOUND") {
      res.status(404).json({ error: "Project not found" });
      return;
    }

    console.error("Failed to fetch observations:", {
      projectId: req.params.id,
      err,
    });

    res.status(500).json({ error: "Failed to fetch observations" });
  }
};

export const handleCreateObservation = async (
  req: Request,
  res: Response,
): Promise<void> => {
  try {
    const { student_name, values } = req.body;

    if (!values || !Array.isArray(values)) {
      res.status(400).json({ error: "values must be an array" });
      return;
    }

    const invalidValue = values.some(
      (v) => typeof v.field_id !== "string" || typeof v.value !== "string",
    );
    if (invalidValue) {
      res
        .status(400)
        .json({ error: "each value must have field_id and value as strings" });
      return;
    }

    const observation = await createObservation(req.params.id as string, {
      student_name: student_name?.trim(),
      values,
    });

    res.status(201).json(observation);
  } catch (err) {
    console.error("Failed to create observation:", {
      projectId: req.params.id,
      err,
    });
    res.status(500).json({ error: "Failed to create observation" });
  }
};
