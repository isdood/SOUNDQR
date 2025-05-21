import { SampleProcessor } from "../../src/processor/SampleProcessor";
import { FLACDecoder, FLACEncoder } from "../../src/codec/FLACCodec";

describe("Metadata Flow", () => {
    test("processes FLAC with ID3 tags", async () => {
        const decoder = new FLACDecoder();
        const encoder = new FLACEncoder();
        const processor = new SampleProcessor(decoder, encoder);
        const testData = await processor.createTestFLACWithID3();
        // Test implementation
    });
});
