import "dotenv/config";
import express from "express";
import { pinoHttp } from "pino-http";
import { v4 as uuidv4 } from "uuid";
import { createHealthRouter } from "./health.js";
import { createLogger } from "./logger.js";
import { createEventBus } from "./events/bus.js";

const port = Number(process.env.PORT ?? 3000);
const serviceName = process.env.SERVICE_NAME ?? "microservice-template";
const logger = createLogger(serviceName);
const eventBus = createEventBus(process.env.EVENT_BUS_DRIVER ?? "memory", logger);

const app = express();
app.use(
  pinoHttp({
    logger,
    genReqId: () => uuidv4(),
  })
);
app.use("/v1", createHealthRouter(serviceName));
app.use((_req, res) => {
  res.status(404).json({
    success: false,
    data: null,
    meta: {},
    error: { code: "NOT_FOUND", message: "Route not found" },
  });
});

eventBus.start().then(() => {
  app.listen(port, () => logger.info({ port }, "service started"));
});
