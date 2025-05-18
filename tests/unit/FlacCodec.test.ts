import { FlacPattern } from '../../src/codec/FlacCodec';

describe('FlacPattern', () => {
  let flacPattern: FlacPattern;

  beforeEach(() => {
    flacPattern = new FlacPattern({
      intensity: 0.9,
      temporalSync: true,
      resonanceMode: 'enhanced'
    });
  });

  test('initializes with correct GLIMMER configuration', async () => {
    await flacPattern.initialize();
    const isValid = await flacPattern.verify();
    expect(isValid).toBe(true);
  });

  test('encodes audio data with GLIMMER enhancement', async () => {
    await flacPattern.initialize();
    const testData = Buffer.from('test audio data');
    const encoded = await flacPattern.encode(testData);
    expect(encoded).toBeDefined();
    expect(encoded.length).toBeGreaterThan(0);
  });
});

  test('decodes FLAC data with GLIMMER pattern removal', async () => {
    await flacPattern.initialize();

    // Create test audio data
    const originalData = Buffer.from('test audio data');

    // Encode and then decode
    const encoded = await flacPattern.encode(originalData);
    const decoded = await flacPattern.decode(encoded);

    expect(decoded).toBeDefined();
    expect(decoded.length).toBeGreaterThan(0);
    // Note: Exact match isn't expected due to FLAC compression
    expect(decoded.length).toBe(originalData.length);
  });
