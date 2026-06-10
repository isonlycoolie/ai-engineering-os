from config.celery import app


@app.task(name="tasks.example.ping")
def ping() -> str:
    """Example background task stub."""
    return "pong"
