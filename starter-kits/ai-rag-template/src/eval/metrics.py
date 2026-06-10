        out_file = out_dir / f"eval_{timestamp}.json"

        payload = {
            **asdict(result),
            "recorded_at": datetime.now(timezone.utc).isoformat(),
        }
        out_file.write_text(json.dumps(payload, indent=2), encoding="utf-8")
