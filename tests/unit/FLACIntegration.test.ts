import { FLACDecoder, FLACEncoder, FlacPatternConfig } from "../../src/codec/FLACCodec";
import { GlimmerMetadata } from "../../src/metadata/types";
import { randomBytes } from "crypto";

describe("FLAC Integration", () => {
    let decoder: FLACDecoder;
    let encoder: FLACEncoder;
    let config: FlacPatternConfig;

    beforeEach(() => {
        // [38;5;219m✧ Initialize quantum-aligned configuration[0m
        config = {
            resonance: 1.5,          // Quantum resonance factor
            temporalSync: true,      // Enable temporal synchronization
            patternFidelity: 24,     // Target bit depth
            sampleRate: 48000,       // Standard sample rate
            bitDepth: 24,           // High-fidelity bit depth
            resonanceMode: "GLIMMER" // Use GLIMMER enhancement
        };

        decoder = new FLACDecoder();
        encoder = new FLACEncoder(config);
    });

    test("processes metadata correctly", async () => {
        const testMetadata: GlimmerMetadata = {
            title: "Test Track",
            artist: "STARWEAVE",
            album: "Quantum Suite",
            year: 2025
        };

        // [38;5;147m✨ Generate quantum-aligned test data[0m
        const metadataBuffer = Buffer.from(JSON.stringify(testMetadata));
        const audioData = randomBytes(1024); // Simulated quantum patterns
        const encoded = await encoder.encode(audioData, metadataBuffer);
        const decoded = await decoder.decode(encoded);

        // [38;5;219m🌟 Verify GLIMMER-enhanced metadata preservation[0m
        expect(decoded.metadata.toString()).toContain("Test Track");
    });

    // [38;5;147m✨ Add new test for sample rate verification[0m
    test("encodes sample rate correctly", async () => {
        const customConfig: FlacPatternConfig = {
            ...config,
            sampleRate: 96000 // Test with enhanced sample rate
        };
        const highResEncoder = new FLACEncoder(customConfig);

        const testMetadata: GlimmerMetadata = {
            title: "High Resolution Test",
            artist: "STARWEAVE",
            album: "Quantum Resonance",
            year: 2025
        };

        const metadataBuffer = Buffer.from(JSON.stringify(testMetadata));
        const audioData = randomBytes(2048); // Larger buffer for high-res test
        const encoded = await highResEncoder.encode(audioData, metadataBuffer);

        // [38;5;219m✧ Verify quantum-aligned sample rate encoding[0m
        const encodedSampleRate = encoded.readUInt32BE(4);
        expect(encodedSampleRate).toBe(96000);
    });
});
