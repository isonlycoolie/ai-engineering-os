export interface ApiEnvelope<T> {
  success: boolean;
  data: T;
  meta: Record<string, unknown>;
  error: ApiError | null;
}

export interface ApiError {
  code: string;
  message: string;
}

export interface HealthData {
  status: 'ok' | 'degraded' | 'down';
  service: string;
}

export type HealthResponse = ApiEnvelope<HealthData>;
