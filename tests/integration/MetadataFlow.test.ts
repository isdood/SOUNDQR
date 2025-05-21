describe("Metadata Flow", () => {
    test("processes FLAC with ID3 tags", async () => {
        const sampleProcessor = new SampleProcessor(
            new FLACDecoder(),
            new FLACEncoder()
        );
        const testData = await sampleProcessor.createTestFLACWithID3();
        // Test implementation
    });
});
