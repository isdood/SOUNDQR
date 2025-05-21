import { SampleProcessor } from "../../src/processor/SampleProcessor";
import { FLACDecoder, FLACEncoder } from "../../src/codec/FLACCodec";
import * as fs from "fs/promises";
import * as path from "path";

describe("GLIMMER-Enhanced Sample Processor", () => {
    let sampleProcessor: SampleProcessor;
    let flacDecoder: FLACDecoder;
    let flacEncoder: FLACEncoder;

    beforeEach(() => {
        flacDecoder = new FLACDecoder();
        flacEncoder = new FLACEncoder();
        sampleProcessor = new SampleProcessor(flacDecoder, flacEncoder);
    });

    describe("Sample Generation", () => {
        test("creates FLAC with ID3 tags", async () => {
            const sample = await sampleProcessor.createTestFLACWithID3();
            expect(sample).toBeDefined();
            expect(sample.length).toBeGreaterThan(0);

            const { metadata } = await flacDecoder.decode(sample);
            expect(metadata.toString()).toContain("ID3");
        });

        test("creates FLAC with Vorbis comments", async () => {
            const sample = await sampleProcessor.createTestFLACWithVorbis();
            expect(sample).toBeDefined();

            const { metadata } = await flacDecoder.decode(sample);
            expect(metadata.toString()).toContain("GLIMMER");
        });
    });
});
