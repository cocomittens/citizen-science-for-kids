import { Router } from "express";
import { requireAuth } from "../middleware/requireAuth";
import {
  handleGetAllProjects,
  handleGetProjectById,
  handleGetProjectByClassCode,
  handleCreateProject,
  handleUpdateProject,
  handleDeleteProject,
  handleExportProjectCSV,
} from "../controllers/projectController";

import {
  handleGetFields,
  handleCreateField,
} from "../controllers/fieldController";

import {
  handleGetObservations,
  handleCreateObservation,
  handleUpdateObservation,
} from "../controllers/observationController";

const router = Router();

router.get("/", requireAuth, handleGetAllProjects);
router.get("/code/:classCode", handleGetProjectByClassCode);
router.patch("/observations/:id", handleUpdateObservation);
router.get("/:id", handleGetProjectById);
router.get("/:id/fields", handleGetFields);
router.get("/:id/observations", handleGetObservations);
router.post("/:id/fields", requireAuth, handleCreateField);
router.post("/:id/observations", handleCreateObservation);
router.post("/", requireAuth, handleCreateProject);
router.put("/:id", requireAuth, handleUpdateProject);
router.delete("/:id", requireAuth, handleDeleteProject);
router.get("/:id/export", requireAuth, handleExportProjectCSV);

export default router;
