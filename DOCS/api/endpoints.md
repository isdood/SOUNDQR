# STARWEAVE API Endpoints
[38;5;81m> Last Updated: 2025-05-18 15:15:03 UTC(B[m

## Overview

The STARWEAVE API provides endpoints for QR code generation, FLAC encoding/decoding, and metadata management. All endpoints are prefixed with \`/api/v1\`.

## Authentication Required

All endpoints require authentication unless marked as \`[Public]\`. See [Authentication](authentication.md) for details.

## Endpoints

### QR Code Operations

#### Generate QR Code
\`POST /api/v1/qr/generate\`

Generates a QR code from FLAC audio data and metadata.

**Request Body:**
\`\`\`json
{
    "audio": "base64_encoded_flac_data",
    "metadata": {
        "title": "string",
        "artist": "string",
        "album": "string",
        "year": "number",
        "custom_fields": {}
    },
    "options": {
        "error_correction": "L|M|Q|H",
        "size": "number",
        "format": "png|svg"
    }
}
\`\`\`

**Response:** PNG or SVG image data

---

#### Decode QR Code
\`POST /api/v1/qr/decode\`

Decodes a QR code back into FLAC audio and metadata.

**Request Body:**
\`\`\`json
{
    "qr_image": "base64_encoded_image"
}
\`\`\`

**Response:**
\`\`\`json
{
    "audio": "base64_encoded_flac_data",
    "metadata": {
        "title": "string",
        "artist": "string",
        "album": "string",
        "year": "number",
        "custom_fields": {}
    }
}
\`\`\`

### FLAC Operations

#### Validate FLAC
\`POST /api/v1/flac/validate\`

Validates FLAC audio data before QR code generation.

**Request Body:**
\`\`\`json
{
    "audio": "base64_encoded_flac_data"
}
\`\`\`

**Response:**
\`\`\`json
{
    "valid": "boolean",
    "details": {
        "sample_rate": "number",
        "bit_depth": "number",
        "channels": "number",
        "duration": "number"
    }
}
\`\`\`

### Metadata Operations

#### Extract Metadata [Public]
\`GET /api/v1/metadata/{qr_id}\`

Extracts metadata from a previously generated QR code.

**Response:**
\`\`\`json
{
    "metadata": {
        "title": "string",
        "artist": "string",
        "album": "string",
        "year": "number",
        "custom_fields": {}
    }
}
\`\`\`

## Rate Limits

See [Rate Limits](rate-limits.md) for detailed information about API rate limiting.

## Error Codes

For a comprehensive list of error codes and their meanings, see [Error Handling](error-handling.md).

## GLIMMER Integration

All endpoints support GLIMMER visualization headers for enhanced data representation. Add \`Accept: application/vnd.starweave.glimmer+json\` to receive GLIMMER-enhanced responses.
