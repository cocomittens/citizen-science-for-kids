import { Router } from "express";
import { requireAuth } from "../middleware/requireAuth";
import {
  handleCreateProject,
  handleGetAllProjects,
  handleGetProjectById,
} from "../controllers/projectController";

const router = Router();

router.use(requireAuth);

router.post("/", handleCreateProject);
router.get("/", handleGetAllProjects);
router.get("/:id", handleGetProjectById);

export default router;
