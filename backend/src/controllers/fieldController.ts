import { Response } from "express";
import { AuthRequest } from "../middleware/requireAuth";
import { createField } from "../models/fieldModel";

const VALID_FIELD_TYPES = [
  "text",
  "number",
  "checkbox",
  "dropdown",
  "textarea",
];

export const handleCreateField = async (
  req: AuthRequest,
  res: Response,
): Promise<void> => {
  try {
    const { label, field_type, options } = req.body;

    if (!label || typeof label !== "string" || label.trim() === "") {
      res.status(400).json({ error: "label is required" });
      return;
    }

    if (!field_type || !VALID_FIELD_TYPES.includes(field_type)) {
      res.status(400).json({
        error: `field_type must be one of the following types: ${VALID_FIELD_TYPES.join(", ")}`,
      });
      return;
    }

    if (field_type === "dropdown" && (!options || options.trim() === "")) {
      res
        .status(400)
        .json({ error: "options is required for dropdown fields" });
      return;
    }

    const field = await createField(req.params.id as string, req.teacher!.id, {
      label: label.trim(),
      field_type,
      options: options?.trim(),
    });

    if (!field) {
      res.status(404).json({ error: "Project not found" });
      return;
    }

    res.status(201).json(field);
  } catch (err) {
    console.error("Failed to create field:", {
      teacherId: req.teacher?.id,
      projectId: req.params.id,
      err,
    });
    res.status(500).json({ error: "Failed to create field" });
  }
};
