import { Router } from "express";
import { requireAuth } from "../middleware/requireAuth";
import {
  handleGetAllProjects,
  handleGetProjectById,
  handleGetProjectByClassCode,
  handleCreateProject,
  handleUpdateProject,
  handleDeleteProject,
} from "../controllers/projectController";

import {
  handleGetFields,
  handleCreateField,
} from "../controllers/fieldController";

import { handleCreateObservation } from "../controllers/observationController";

const router = Router();

router.get("/", requireAuth, handleGetAllProjects);
router.get("/code/:classCode", handleGetProjectByClassCode);
router.get("/:id", requireAuth, handleGetProjectById);
router.get("/:id/fields", requireAuth, handleGetFields);
router.post("/:id/fields", requireAuth, handleCreateField);
router.post("/:id/observations", handleCreateObservation);
router.post("/", requireAuth, handleCreateProject);
router.put("/:id", requireAuth, handleUpdateProject);
router.delete("/:id", requireAuth, handleDeleteProject);

export default router;
