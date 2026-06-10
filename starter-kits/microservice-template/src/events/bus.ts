import type { Logger } from "pino";

export interface EventBus {
  publish(topic: string, payload: unknown): Promise<void>;
  start(): Promise<void>;
  stop(): Promise<void>;
}

class InMemoryEventBus implements EventBus {
  constructor(private readonly logger: Logger) {}

  async start(): Promise<void> {
    this.logger.info("event bus started (in-memory stub)");
  }

  async stop(): Promise<void> {
    this.logger.info("event bus stopped");
  }

  async publish(topic: string, payload: unknown): Promise<void> {
    this.logger.info({ topic, payload }, "event published (stub)");
  }
}

export function createEventBus(driver: string, logger: Logger): EventBus {
  if (driver === "memory") return new InMemoryEventBus(logger);
  throw new Error(`Unsupported EVENT_BUS_DRIVER: ${driver}`);
}
