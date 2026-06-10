import { describe, it, expect } from "vitest";
import { createHealthRouter } from "../src/health.js";

describe("createHealthRouter", () => {
  it("registers health route handler", () => {
    const router = createHealthRouter("test-service");
    const layer = router.stack.find(
      (s) => s.route?.path === "/health" && s.route.methods.get
    );
    expect(layer).toBeDefined();
  });
});
