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
