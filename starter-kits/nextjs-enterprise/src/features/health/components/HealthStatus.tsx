import type { HealthData } from '../types/health';

interface HealthStatusProps {
  data: HealthData;
}

export function HealthStatus({ data }: HealthStatusProps) {
  return (
    <div className="rounded-lg border border-slate-200 bg-white p-6 shadow-sm">
      <p className="text-sm font-medium text-slate-500">Service status</p>
      <p className="mt-2 text-2xl font-semibold capitalize text-emerald-600">
        {data.status}
      </p>
      <p className="mt-1 text-sm text-slate-600">{data.service}</p>
    </div>
  );
}
