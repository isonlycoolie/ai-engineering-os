# Local Setup - AI RAG Template

Part of the [AI Engineering OS](../../../docs/START-HERE.md).

## Prerequisites

- Python 3.12+
- pip
- Docker (optional, for containerized runs)

## Steps

1. Copy environment variables:

   ```bash
   cp .env.example .env
   ```

2. Install dependencies:

   ```bash
   python -m venv .venv
   source .venv/bin/activate   # Windows: .venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. Run tests:

   ```bash
   pytest -v
   ```

4. (Optional) Run via Docker:

   ```bash
   docker compose -f docker/docker-compose.yml up --build
   ```

## Smoke Test

```python
from src.ingest import Document, ingest_documents, persist_chunks
from src.generate import run_pipeline

docs = [Document(id="1", text="Your knowledge base content here.")]
chunks = ingest_documents(docs)
persist_chunks(chunks)
result = run_pipeline("What is in the knowledge base?")
print(result.answer, result.metrics)
```

## Next Steps

- Replace `StubEmbedder` and `StubLLMClient` with your provider SDKs
- Swap JSON-lines persistence for pgvector, Pinecone, or Chroma
- Extend `src/eval/metrics.py` with LLM-as-judge evaluators
- Add an API layer (FastAPI) or CLI entrypoint
