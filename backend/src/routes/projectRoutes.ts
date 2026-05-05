import { Router } from "express";
import { requireAuth } from "../middleware/requireAuth";
import { handleCreateProject } from "../controllers/projectController";

const router = Router();

router.use(requireAuth);

router.post("/", handleCreateProject);

export default router;
