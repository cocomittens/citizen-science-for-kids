import { Request, Response } from "express";
import { createObservation } from "../models/observationModel";

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
