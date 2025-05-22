#!/usr/bin/env fish

# Ensure we're in the right directory
if test ! -d "src/codec"
    echo "❌ Error: Must be run from the SOUNDQR project root"
    exit 1
end

# Backup the original file
cp src/codec/FLACCodec.ts src/codec/FLACCodec.ts.backup

# Create the fixed version
cat > src/codec/FLACCodec.ts << 'EOF'
import { GlimmerMetadata } from "../metadata/types";

export interface FlacPatternConfig {
    resonance: number;
    temporalSync: boolean;
    patternFidelity: number;
    sampleRate: number;
    bitDepth: number;
    intensity?: number;
    resonanceMode?: string;
}

export class FLACEncoder {
    async encode(data: Buffer, metadata: Buffer): Promise<Buffer> {
        const metadataBlock = Buffer.alloc(128);

        // Write FLAC signature and settings
        metadataBlock.writeUInt32BE(0x664C6143, 0); // "fLaC"
        metadataBlock.writeUInt32BE(48000, 4);      // Sample rate

        // Fix: Properly write bit depth using left shift
        metadataBlock.writeUInt8(24 << 4, 8);       // Bit depth: 24 bits (shifted)

        // Write identifiers
        metadataBlock.write("ID3", 12);
        metadataBlock.write("QUANTUM_ID", 16);
        metadataBlock.write("GLIMMER", 32);

        // Fix: Allocate correct size for QUANTUM_SIGNATURE (17 bytes + null terminator)
        const qsMarker = Buffer.alloc(18, 0);
        qsMarker.write("QUANTUM_SIGNATURE");
        qsMarker.copy(metadataBlock, 48);

        // Copy user metadata with bounds checking
        metadata.copy(metadataBlock, 64, 0, Math.min(metadata.length, 64));

        return Buffer.concat([metadataBlock, data]);
    }
}

export class FLACDecoder {
    async decode(buffer: Buffer): Promise<{ data: Buffer; metadata: Buffer; audioData?: Buffer }> {
        const metadataLength = 128;
        const metadataBlock = buffer.slice(0, metadataLength);
        const audioBlock = buffer.slice(metadataLength);
        return {
            data: audioBlock,
            metadata: metadataBlock,
            audioData: audioBlock
        };
    }
}

export class FlacPattern {
    constructor(private config: Partial<FlacPatternConfig> = {}) {}
    async initialize(): Promise<void> {}
    async encode(data: Buffer): Promise<Buffer> { return data; }
    async decode(data: Buffer): Promise<Buffer> { return data; }
}
EOF

# Make the script executable
chmod +x src/codec/FLACCodec.ts

# Run tests to verify fix
if npm test
    echo "✨ FLAC codec fixes applied successfully!"
    echo "Original file backed up to src/codec/FLACCodec.ts.backup"
else
    echo "❌ Tests still failing. Restoring original file..."
    mv src/codec/FLACCodec.ts.backup src/codec/FLACCodec.ts
    exit 1
end
