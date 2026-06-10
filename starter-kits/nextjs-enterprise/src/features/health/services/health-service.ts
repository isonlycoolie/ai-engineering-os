import { httpClient } from '@/shared/services/http';
import type { HealthResponse } from '../types/health';

export async function fetchHealth(): Promise<HealthResponse> {
  return httpClient.get<HealthResponse>('/api/health');
}
