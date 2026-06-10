export interface HttpClientOptions {
  baseUrl?: string;
  headers?: Record<string, string>;
}

export class HttpError extends Error {
  constructor(
    message: string,
    public readonly status: number,
  ) {
    super(message);
    this.name = 'HttpError';
  }
}

export class HttpClient {
  constructor(private readonly options: HttpClientOptions = {}) {}

  async get<T>(path: string): Promise<T> {
    const url = `${this.options.baseUrl ?? ''}${path}`;
    const response = await fetch(url, {
      method: 'GET',
      headers: {
        Accept: 'application/json',
        ...this.options.headers,
      },
    });

    if (!response.ok) {
      throw new HttpError(`Request failed with status ${response.status}`, response.status);
    }

    return response.json() as Promise<T>;
  }
}

/** Shared HTTP client — extend with auth, retries, and tracing as needed. */
export const httpClient = new HttpClient();
