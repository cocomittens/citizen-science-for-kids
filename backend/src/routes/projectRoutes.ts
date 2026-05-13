import { Router } from "express";
import { requireAuth } from "../middleware/requireAuth";
import {
  handleCreateProject,
  handleGetAllProjects,
  handleGetProjectById,
  handleGetProjectByClassCode,
  handleDeleteProject,
  handleUpdateProject,
} from "../controllers/projectController";

const router = Router();

router.use(requireAuth);

router.post("/", handleCreateProject);
router.get("/", handleGetAllProjects);
router.get("/:id", handleGetProjectById);
router.get("/code/:classCode", handleGetProjectByClassCode);
router.delete("/:id", handleDeleteProject);
router.put("/:id", handleUpdateProject);

export default router;
