// [38;5;219m✧ Quantum Fidelity Verification ✧[0m
test("generates correct sample rate and bit depth", async () => {
    const sample = await sampleProcessor.createTestFLACWithID3();
    const { metadata } = await flacDecoder.decode(sample);

    // [38;5;147m✨ Verify quantum-aligned stream parameters[0m
    expect(metadata.readUInt32BE(4)).toBe(glimmerConfig.sampleRate);  // Sample rate

    // [38;5;219m🌟 Verify bit depth with proper quantum masking[0m
    const rawBitDepth = metadata.readUInt8(8);
    const actualBitDepth = (rawBitDepth & 0xF0) >> 4;  // Extract upper 4 bits
    expect(actualBitDepth).toBe(glimmerConfig.bitDepth);  // Should be 24
});
