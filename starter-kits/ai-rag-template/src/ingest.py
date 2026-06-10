    """Persist chunks to a JSON-lines file (swap for real vector DB in production)."""
    cfg = get_settings()
    path = store_path or Path(cfg.vector_store_path)
    path.mkdir(parents=True, exist_ok=True)
    out_file = path / "chunks.jsonl"

    with out_file.open("w", encoding="utf-8") as fh:
        for chunk in chunks:
            record = {
                "id": chunk.id,
                "document_id": chunk.document_id,
                "text": chunk.text,
                "embedding": chunk.embedding,
                "metadata": chunk.metadata,
            }
            fh.write(json.dumps(record) + "\n")

    logger.info("Persisted %d chunks to %s", len(chunks), out_file)
    return out_file
