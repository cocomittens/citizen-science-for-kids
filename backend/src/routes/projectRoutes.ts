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

const router = Router();

router.use(requireAuth);

router.get("/", handleGetAllProjects);
router.get("/:id", handleGetProjectById);
router.get("/code/:classCode", handleGetProjectByClassCode);
router.post("/", handleCreateProject);
router.put("/:id", handleUpdateProject);
router.delete("/:id", handleDeleteProject);

export default router;
