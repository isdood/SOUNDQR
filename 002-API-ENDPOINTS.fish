#!/usr/bin/env fish

# STARWEAVE API Documentation Generator - Endpoints
# Created: 2025-05-18 15:13:26 UTC
# Author: isdood

# GLIMMER color palette
set -l shimmer_purple (tput setaf 93)
set -l cosmic_blue (tput setaf 75)
set -l starlight_cyan (tput setaf 81)
set -l nebula_green (tput setaf 120)
set -l reset (tput sgr0)

function echo_starweave
    echo $shimmer_purple"[STARWEAVE] "$cosmic_blue$argv$reset
end

set api_dir "DOCS/api"
set endpoints_file "$api_dir/endpoints.md"

# Check if directory exists
if not test -d $api_dir
    echo_starweave "✧ Creating API documentation directory..."
    mkdir -p $api_dir
end

echo_starweave "✧ Generating API endpoints documentation..."

# Generate endpoints documentation
echo "\
# STARWEAVE API Endpoints
$starlight_cyan> Last Updated: "(date -u +"%Y-%m-%d %H:%M:%S")" UTC$reset

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
    \"audio\": \"base64_encoded_flac_data\",
    \"metadata\": {
        \"title\": \"string\",
        \"artist\": \"string\",
        \"album\": \"string\",
        \"year\": \"number\",
        \"custom_fields\": {}
    },
    \"options\": {
        \"error_correction\": \"L|M|Q|H\",
        \"size\": \"number\",
        \"format\": \"png|svg\"
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
    \"qr_image\": \"base64_encoded_image\"
}
\`\`\`

**Response:**
\`\`\`json
{
    \"audio\": \"base64_encoded_flac_data\",
    \"metadata\": {
        \"title\": \"string\",
        \"artist\": \"string\",
        \"album\": \"string\",
        \"year\": \"number\",
        \"custom_fields\": {}
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
    \"audio\": \"base64_encoded_flac_data\"
}
\`\`\`

**Response:**
\`\`\`json
{
    \"valid\": \"boolean\",
    \"details\": {
        \"sample_rate\": \"number\",
        \"bit_depth\": \"number\",
        \"channels\": \"number\",
        \"duration\": \"number\"
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
    \"metadata\": {
        \"title\": \"string\",
        \"artist\": \"string\",
        \"album\": \"string\",
        \"year\": \"number\",
        \"custom_fields\": {}
    }
}
\`\`\`

## Rate Limits

See [Rate Limits](rate-limits.md) for detailed information about API rate limiting.

## Error Codes

For a comprehensive list of error codes and their meanings, see [Error Handling](error-handling.md).

## GLIMMER Integration

All endpoints support GLIMMER visualization headers for enhanced data representation. Add \`Accept: application/vnd.starweave.glimmer+json\` to receive GLIMMER-enhanced responses." > $endpoints_file

# Verify file creation
if test -f $endpoints_file
    echo $nebula_green"✧ Successfully generated endpoints documentation!"$reset
    echo $starlight_cyan"✧ Location: $endpoints_file"$reset
else
    echo $shimmer_purple"✧ Error: Failed to create endpoints documentation."$reset
    exit 1
end

echo_starweave "✧ Ready for the next documentation script! ✨"
