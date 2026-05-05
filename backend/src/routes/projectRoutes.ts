import { Router } from "express";
import { requireAuth } from "../middleware/requireAuth";
import {
  handleCreateProject,
  handleGetAllProjects,
} from "../controllers/projectController";

const router = Router();

router.use(requireAuth);

router.post("/", handleCreateProject);
router.get("/:id", handleGetAllProjects);

export default router;
