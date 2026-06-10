# Node.js base image — production-oriented stub
#
# Build: docker build -f docker/node-base/Dockerfile -t org/node-base:22 .
# Extend this image in service-specific Dockerfiles; do not run as root in production.

ARG NODE_VERSION=22-alpine
FROM node:${NODE_VERSION} AS base

# Install dumb-init for proper PID 1 signal handling
RUN apk add --no-cache dumb-init

WORKDIR /app

# Create non-root user
RUN addgroup -g 1001 -S app && adduser -S app -u 1001 -G app

# --- Dependencies stage (override COPY paths in service Dockerfile) ---
FROM base AS deps
COPY package.json package-lock.json* ./
RUN npm ci --omit=dev && npm cache clean --force

# --- Runtime stage ---
FROM base AS runtime
ENV NODE_ENV=production
ENV NODE_OPTIONS="--enable-source-maps"

COPY --from=deps --chown=app:app /app/node_modules ./node_modules
# COPY --chown=app:app dist ./dist

USER app

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://127.0.0.1:3000/health || exit 1

ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "dist/index.js"]
