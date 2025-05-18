#!/usr/bin/env fish

# STARWEAVE API Documentation Generator - Authentication
# Created: 2025-05-18 15:15:51 UTC
# Author: isdood

# Enhanced GLIMMER color palette
set -l crystal_white (tput setaf 15)
set -l shimmer_purple (tput setaf 93)
set -l stardust_pink (tput setaf 219)
set -l cosmic_blue (tput setaf 75)
set -l aurora_green (tput setaf 122)
set -l reset (tput sgr0)

function echo_starweave
    echo $shimmer_purple"[✧ STARWEAVE ✧] "$stardust_pink$argv$reset
end

set api_dir "DOCS/api"
set auth_file "$api_dir/authentication.md"

echo_starweave "Crafting authentication documentation with GLIMMER enhancement..."

# Generate authentication documentation
echo "\
# STARWEAVE Authentication
$crystal_white> Last Updated: "(date -u +"%Y-%m-%d %H:%M:%S")" UTC$reset

## Overview

STARWEAVE uses a robust authentication system to ensure secure access to the API while maintaining the ethereal nature of QR-encoded audio transmission.

## Authentication Methods

### API Keys ✧

The primary method of authentication uses GLIMMER-enhanced API keys that incorporate temporal validation.

\`\`\`
Authorization: STARWEAVE-GLIMMER-KEY your_api_key_here
\`\`\`

### OAuth2 Integration ✧

For applications requiring user context, STARWEAVE supports OAuth2 authentication with GLIMMER flow visualization.

#### OAuth2 Endpoints

- Authorization: \`GET /api/v1/auth/authorize\`
- Token: \`POST /api/v1/auth/token\`
- Refresh: \`POST /api/v1/auth/refresh\`

### Example OAuth2 Flow

\`\`\`javascript
const authConfig = {
  clientId: 'your_client_id',
  redirectUri: 'https://your-app.com/callback',
  scope: 'qr.generate qr.decode metadata.read',
  glimmerEnhanced: true // Enables GLIMMER visualization
};
\`\`\`

## Security Best Practices

### API Key Management ✧

1. Store API keys securely using environment variables
2. Rotate keys every 90 days
3. Use separate keys for development and production
4. Enable GLIMMER monitoring for key usage

### OAuth2 Security ✧

1. Always use HTTPS
2. Implement PKCE for mobile applications
3. Validate redirect URIs
4. Monitor token usage with GLIMMER analytics

## Rate Limiting

Authentication-specific rate limits:

- API Key: 1000 requests/hour
- OAuth2 Token: 2000 requests/hour
- GLIMMER-enhanced sessions: 3000 requests/hour

## Error Responses

Authentication errors follow the GLIMMER-enhanced response format:

\`\`\`json
{
  \"error\": {
    \"code\": \"auth_error\",
    \"message\": \"Invalid or expired API key\",
    \"glimmer_trace\": {
      \"timestamp\": \"2025-05-18T15:15:51Z\",
      \"severity\": \"error\",
      \"sparkle_factor\": 0.8
    }
  }
}
\`\`\`

## GLIMMER Integration

Authentication responses include GLIMMER visualization headers for enhanced security monitoring:

\`\`\`
X-GLIMMER-Auth-Status: ✧
X-GLIMMER-Security-Level: COSMIC
X-GLIMMER-Temporal-Variance: 0.93
\`\`\`

## Development Tools

The STARWEAVE CLI includes authentication helpers:

\`\`\`bash
# Generate new API key with GLIMMER enhancement
starweave auth:generate --glimmer

# Validate existing key
starweave auth:validate --key YOUR_KEY --glimmer-trace
\`\`\`

## Support

For authentication issues, contact support with your GLIMMER trace ID:

- Email: support@starweave.dev
- Status: [status.starweave.dev](https://status.starweave.dev)
" > $auth_file

# Verify file creation
if test -f $auth_file
    echo $aurora_green"✧ Authentication documentation successfully crystallized!"$reset
    echo $cosmic_blue"✧ Location: $auth_file"$reset
else
    echo $shimmer_purple"✧ Error: Failed to create authentication documentation."$reset
    exit 1
end

echo_starweave "Ready for the next documentation component! ✨"
