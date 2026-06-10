import { describe, expect, it, vi } from 'vitest';
import { HttpClient } from '@/shared/services/http';

describe('HttpClient', () => {
  it('returns parsed JSON on successful GET', async () => {
    const payload = { success: true, data: { status: 'ok' } };
    global.fetch = vi.fn().mockResolvedValue({
      ok: true,
      json: async () => payload,
    }) as unknown as typeof fetch;

    const client = new HttpClient();
    const result = await client.get<typeof payload>('/api/health');

    expect(result).toEqual(payload);
    expect(fetch).toHaveBeenCalledWith('/api/health', {
      method: 'GET',
      headers: { Accept: 'application/json' },
    });
  });
});
