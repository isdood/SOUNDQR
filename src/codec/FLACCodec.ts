export class FLACEncoder {
    async encode(data: Buffer, metadata: Buffer): Promise<Buffer> {
        const metadataBlock = Buffer.alloc(128);
        metadata.copy(metadataBlock, 0, 0, Math.min(metadata.length, 128));

        // Add FLAC stream markers with proper bit depth calculation
        metadataBlock.writeUInt32BE(0x664C6143, 0); // "fLaC"
        metadataBlock.writeUInt32BE(48000, 4);      // Sample rate
        metadataBlock.writeUInt8((24 << 4) & 0xFF, 8); // Bit depth (shifted and masked)

        // Add ID3/Vorbis identifier
        if (metadata.toString().includes("ID3")) {
            metadataBlock.write("ID3", 16);
        } else {
            metadataBlock.write("VBF", 16);
        }

        return Buffer.concat([metadataBlock, data]);
    }
}
