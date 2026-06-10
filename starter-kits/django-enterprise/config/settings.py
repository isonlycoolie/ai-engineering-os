    """Emit structured JSON logs per observability standards."""

    def format(self, record: logging.LogRecord) -> str:
        payload = {
            "timestamp": self.formatTime(record, datefmt="%Y-%m-%dT%H:%M:%S"),
            "level": record.levelname.lower(),
            "service": SERVICE_NAME,
            "message": record.getMessage(),
        }
        if record.exc_info:
            payload["error"] = {"detail": self.formatException(record.exc_info)}
        return json.dumps(payload)


LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "json": {
            "()": JsonLogFormatter,
        },
    },
    "handlers": {
        "console": {
            "class": "logging.StreamHandler",
            "formatter": "json",
        },
    },
    "root": {
        "handlers": ["console"],
        "level": LOG_LEVEL,
    },
}
