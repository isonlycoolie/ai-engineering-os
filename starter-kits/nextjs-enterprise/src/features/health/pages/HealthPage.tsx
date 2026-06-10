'use client';

import { useHealth } from '../api/use-health';
import { HealthStatus } from '../components/HealthStatus';

export function HealthPage() {
  const { data, isLoading, isError, error } = useHealth();

  return (
    <main className="mx-auto flex min-h-screen max-w-2xl flex-col justify-center px-6 py-16">
      <h1 className="text-3xl font-bold tracking-tight">Next.js Enterprise</h1>
      <p className="mt-2 text-slate-600">
        Feature-based starter with health check wiring.
      </p>

      <div className="mt-8">
        {isLoading && (
          <p className="text-sm text-slate-500">Checking service health…</p>
        )}
        {isError && (
          <p className="text-sm text-red-600">
            Health check failed: {error instanceof Error ? error.message : 'Unknown error'}
          </p>
        )}
        {data?.success && data.data && <HealthStatus data={data.data} />}
      </div>
    </main>
  );
}
