# Monitoring

Alert templates and operational monitoring guidance for production services.

## Layout

```
monitoring/
└── alerts/
    ├── slo-burn-rate.yml   # Multi-window burn-rate alerts
    ├── error-rate.yml      # HTTP / RPC error rate thresholds
    └── latency-p95.yml     # Latency SLO breach detection
```

## Alert philosophy

- **Page on symptoms, not causes** - alert on user-impacting SLO breaches first.
- **Multi-window burn rates** - combine short and long windows to catch fast and slow burns ([Google SRE workbook](https://sre.google/workbook/alerting-on-slos/)).
- **Actionable runbooks** - every alert links to a runbook with verification steps and rollback guidance.

## Integration

Import templates into your observability platform:

| Platform | Import path |
|----------|-------------|
| Prometheus / Alertmanager | Convert YAML rules to `PrometheusRule` CRDs |
| Datadog | Map to monitor JSON via API or Terraform provider |
| Grafana Mimir / Loki | Use recording rules + alert definitions |

## SLO targets (defaults - adjust per service)

| SLI | Target | Measurement window |
|-----|--------|-------------------|
| Availability | 99.9% | 30 days |
| Error rate | < 0.1% of requests | 5 minutes |
| Latency p95 | < 500 ms | 5 minutes |

## Related documentation

- [Observability standards](../standards/observability.md)
- [SRE runbook template](../agents/sre-engineer/templates/runbook.md)
- [Pre-production checklist](../agents/sre-engineer/checklists/pre-production.md)
