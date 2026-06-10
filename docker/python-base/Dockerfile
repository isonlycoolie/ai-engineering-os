# Python base image — production-oriented stub
#
# Build: docker build -f docker/python-base/Dockerfile -t org/python-base:3.12 .
# Use multi-stage builds in service Dockerfiles to keep runtime images minimal.

ARG PYTHON_VERSION=3.12-slim
FROM python:${PYTHON_VERSION} AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

RUN groupadd -r app && useradd -r -g app -u 1001 app

# --- Dependencies stage ---
FROM base AS deps
COPY requirements.txt ./
RUN pip install --upgrade pip && pip install -r requirements.txt

# --- Runtime stage ---
FROM base AS runtime
ENV APP_ENV=production

COPY --from=deps /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=deps /usr/local/bin /usr/local/bin
# COPY --chown=app:app src ./src

USER app

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8000/health')" || exit 1

CMD ["python", "-m", "uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
