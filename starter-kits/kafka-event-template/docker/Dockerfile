ARG PYTHON_VERSION=3.12-slim
FROM python:${PYTHON_VERSION}

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

RUN groupadd -r app && useradd -r -g app -u 1001 app

COPY requirements.txt ./
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY src ./src
COPY tests ./tests

RUN chown -R app:app /app
USER app

CMD ["python", "-m", "src.consumer"]
