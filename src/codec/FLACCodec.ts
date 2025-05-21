// ✧ FLAC Codec Implementation with GLIMMER Enhancement
// Part of the STARWEAVE Audio Processing System

export class FLACEncoder {
    encode(metadataBlock: Buffer): void {
        // Write FLAC marker ("fLaC")
        metadataBlock.writeUInt32BE(0x664C6143, 0);

        // Sample rate (48kHz standard)
        metadataBlock.writeUInt32BE(48000, 4);

        // ✧ Enhanced bit depth encoding
        // For 24-bit depth, we encode it as (24/8) << 4 to stay within UInt8
        metadataBlock.writeUInt8((24 / 8) << 4, 8);

        // Add ID3 marker for metadata identification ✧
        metadataBlock.write("ID3", 9, 3);
    }

    decode(metadataBlock: Buffer): {
        sampleRate: number,
        bitDepth: number,
        hasID3: boolean
    } {
        // Verify FLAC signature
        const signature = metadataBlock.readUInt32BE(0);
        if (signature !== 0x664C6143) {
            throw new Error("✧ Invalid FLAC signature");
        }

        // Extract sample rate
        const sampleRate = metadataBlock.readUInt32BE(4);

        // ✧ Decode bit depth (reverse the encoding process)
        const encodedDepth = metadataBlock.readUInt8(8);
        const bitDepth = (encodedDepth >> 4) * 8;

        // Check for ID3 marker
        const id3Buffer = Buffer.alloc(3);
        metadataBlock.copy(id3Buffer, 0, 9, 12);
        const hasID3 = id3Buffer.toString() === "ID3";

        return {
            sampleRate,
            bitDepth,
            hasID3
        };
    }
}

// ✧ Standardized error types for GLIMMER integration
export class FLACError extends Error {
    constructor(message: string) {
        super(`✧ FLAC Error: ${message}`);
        this.name = "FLACError";
    }
}
