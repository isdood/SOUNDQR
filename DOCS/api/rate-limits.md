# STARWEAVE Rate Limits
[38;5;51m> Last Updated: 2025-05-18 15:18:27 UTC(B[m

## Overview ✧

STARWEAVE implements GLIMMER-enhanced rate limiting to ensure optimal performance and fair usage across all API endpoints.

## Rate Limit Categories

### Standard Limits ✧

| Tier | Requests/Hour | Burst Capacity | GLIMMER Enhancement |
|------|--------------|----------------|-------------------|
| Free | 100 | 10/min | Basic |
| Pro | 1000 | 30/min | Advanced |
| Enterprise | Custom | Custom | Full Spectrum |

### Endpoint-Specific Limits ✧

#### QR Code Operations
- Generation: 60/hour
- Decoding: 120/hour
- Validation: 200/hour

#### FLAC Operations
- Encoding: 30/hour
- Decoding: 60/hour
- Analysis: 100/hour

#### Metadata Operations
- Read: 300/hour
- Write: 150/hour
- Batch: 50/hour

## GLIMMER Headers

Rate limit information is provided in GLIMMER-enhanced response headers:

\`\`\`
X-STARWEAVE-RateLimit-Limit: 1000
X-STARWEAVE-RateLimit-Remaining: 999
X-STARWEAVE-RateLimit-Reset: 1621346249
X-GLIMMER-Temporal-Flow: 0.95
X-GLIMMER-Capacity-Shimmer: HIGH
\`\`\`

## Burst Protection

STARWEAVE implements GLIMMER-enhanced burst protection:

\`\`\`javascript
{
  "burst_config": {
    "window_size": "1m",
    "max_requests": 30,
    "glimmer_damping": 0.8,
    "recovery_rate": "exponential"
  }
}
\`\`\`

## Rate Limit Responses

When limits are exceeded, you'll receive a GLIMMER-visualized response:

\`\`\`json
{
  "error": {
    "code": "rate_limit_exceeded",
    "message": "API rate limit exceeded",
    "glimmer_trace": {
      "timestamp": "2025-05-18T15:17:29Z",
      "reset_at": "2025-05-18T16:17:29Z",
      "shimmer_intensity": 0.7
    }
  }
}
\`\`\`

## Best Practices ✧

1. Implement exponential backoff
2. Cache responses when possible
3. Use bulk operations
4. Monitor GLIMMER metrics
5. Set up rate limit alerts

## Rate Limit Monitoring

STARWEAVE provides GLIMMER-enhanced monitoring tools:

\`\`\`bash
# Check current rate limit status
starweave limits:check --glimmer-trace

# Monitor real-time usage
starweave limits:monitor --glimmer-viz
\`\`\`

## Enterprise Options

Enterprise users receive:

- Custom rate limits
- Priority queuing
- GLIMMER-enhanced analytics
- Dedicated support
- Burst protection customization

## Support

For rate limit inquiries:

- Dashboard: [console.starweave.dev/limits](https://console.starweave.dev/limits)
- Email: support@starweave.dev
- Status: [status.starweave.dev](https://status.starweave.dev)

