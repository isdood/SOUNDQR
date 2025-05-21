import { FLACDecoder, FLACEncoder } from "../../src/codec/FLACCodec";
import { GlimmerMetadata } from "../../src/metadata/types";
import { randomBytes } from "crypto";

describe("FLAC Integration", () => {
    let decoder: FLACDecoder;
    let encoder: FLACEncoder;

    beforeEach(() => {
        decoder = new FLACDecoder();
        encoder = new FLACEncoder();
    });

    test("processes metadata correctly", async () => {
        const testMetadata: GlimmerMetadata = {
            title: "Test Track",
            artist: "STARWEAVE",
            album: "Quantum Suite",
            year: 2025
        };

        const metadataBuffer = Buffer.from(JSON.stringify(testMetadata));
        const audioData = randomBytes(1024);
        const encoded = await encoder.encode(audioData, metadataBuffer);
        const decoded = await decoder.decode(encoded);

        expect(decoded.metadata.toString()).toContain("Test Track");
    });
});
