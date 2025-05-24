import { SampleProcessor } from "../../src/processor/SampleProcessor";
import { FLACDecoder, FLACEncoder, FlacPatternConfig } from "../../src/codec/FLACCodec";
import * as fs from "fs/promises";
import * as path from "path";

// [38;5;219m✧ STARWEAVE Test Suite: Quantum-Aligned Sample Processing ✧[0m
describe("GLIMMER-Enhanced Sample Processor", () => {
    let sampleProcessor: SampleProcessor;
    let flacDecoder: FLACDecoder;
    let flacEncoder: FLACEncoder;
    let glimmerConfig: FlacPatternConfig;

    beforeEach(() => {
        // [38;5;147m✨ Initialize quantum-aligned configuration[0m
        glimmerConfig = {
            resonance: 1.5,
            temporalSync: true,
            patternFidelity: 24,
            sampleRate: 48000,
            bitDepth: 24,
            resonanceMode: "GLIMMER"
        };

        flacDecoder = new FLACDecoder();
        flacEncoder = new FLACEncoder(glimmerConfig);
        sampleProcessor = new SampleProcessor(flacDecoder, flacEncoder);
    });

    describe("Sample Generation", () => {
        test("creates FLAC with ID3 tags", async () => {
            const sample = await sampleProcessor.createTestFLACWithID3();
            expect(sample).toBeDefined();
            expect(sample.length).toBeGreaterThan(0);

            const { metadata } = await flacDecoder.decode(sample);
            expect(metadata.toString()).toContain("ID3");
            expect(metadata.toString()).toContain("QUANTUM_ID");
        });

        test("creates FLAC with Vorbis comments", async () => {
            const sample = await sampleProcessor.createTestFLACWithVorbis();
            expect(sample).toBeDefined();

            const { metadata } = await flacDecoder.decode(sample);
            expect(metadata.toString()).toContain("GLIMMER");
            expect(metadata.toString()).toContain("QUANTUM_SIGNATURE");
        });

        // [38;5;219m✧ Inside the test case[0m]
        test("generates correct sample rate and bit depth", async () => {
            const sample = await sampleProcessor.createTestFLACWithID3();
            const { metadata } = await flacDecoder.decode(sample);

            // [38;5;147m✨ Verify quantum-aligned stream parameters[0m]
            expect(metadata.readUInt32BE(4)).toBe(glimmerConfig.sampleRate);

            // [38;5;219m🌟 Complete quantum cycle for bit depth[0m]
            const rawBitDepth = metadata.readUInt8(8);
            const encodedValue = (rawBitDepth & 0xF0) >> 4;  // Get encoded value (12)
            const actualBitDepth = encodedValue * 2;         // Complete quantum cycle (24)
            expect(actualBitDepth).toBe(glimmerConfig.bitDepth);
        });
    });
});
