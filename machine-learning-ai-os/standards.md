# Standards

## Data and features

- Train/validation/test splits documented. No leakage from future data.
- Feature definitions versioned. Point-in-time correctness for historical features.

## Training and evaluation

- Baseline model required. Metrics aligned to business outcome.
- Evaluate on held-out data. Document class imbalance handling.

## Deployment

- Train/serve skew checked. Rollback to prior model documented.
- Monitor latency, error rate, and prediction drift.

## Governance

- Model card: intended use, limitations, bias risks, retrain cadence.
