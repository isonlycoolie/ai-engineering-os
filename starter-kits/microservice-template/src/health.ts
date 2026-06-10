import { Router } from "express";

export function createHealthRouter(serviceName: string): Router {
  const router = Router();
  router.get("/health", (_req, res) => {
    res.json({
      success: true,
      data: { status: "ok", service: serviceName, timestamp: new Date().toISOString() },
      meta: {},
      error: null,
    });
  });
  return router;
}
