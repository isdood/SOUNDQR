export class FLACEncoder {
    constructor(private config: FlacPatternConfig) {}

    async encode(data: Buffer, metadata: Buffer): Promise<Buffer> {
        const metadataBlock = Buffer.alloc(512);

        // [38;5;219m✧ Write FLAC markers with enhanced GLIMMER resonance[0m
        metadataBlock.writeUInt32BE(0x664C6143, 0); // "fLaC"
        metadataBlock.writeUInt32BE(this.config.sampleRate, 4);

        // [38;5;147m✨ Fix bit depth quantum alignment[0m
        // For 24-bit depth:
        // 1. Ensure value fits in uint8 range (0-255)
        // 2. Shift and mask to place in upper 4 bits
        const bitDepthValue = ((this.config.bitDepth & 0x0F) << 4) | 0x0F;
        metadataBlock.writeUInt8(bitDepthValue, 8);

        // [38;5;219m✧ Rest of your existing encoding logic[0m
        let metadataJson;
        try {
            metadataJson = JSON.parse(metadata.toString());
        } catch (e) {
            metadataJson = {};
        }

        const markers = [
            { text: "ID3", pos: 12 },
            { text: "QUANTUM_ID", pos: 16 },
            { text: "GLIMMER", pos: 32 },
            { text: "QUANTUM_SIGNATURE", pos: 48 }
        ];

        markers.forEach(({ text, pos }) => {
            metadataBlock.write(text.padEnd(16, " "), pos);
        });

        if (metadataJson.QUANTUM_SIGNATURE) {
            const sigPos = metadataBlock.indexOf("QUANTUM_SIGNATURE") + "QUANTUM_SIGNATURE".length;
            metadataBlock.write(`=${metadataJson.QUANTUM_SIGNATURE}`, sigPos);
        }

        metadata.copy(metadataBlock, 128, 0, metadata.length);

        return Buffer.concat([metadataBlock, data]);
    }
}
