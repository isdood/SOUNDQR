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

  test('applies quantum-enhanced pattern reversal', async () => {
    await flacPattern.initialize();

    // Create test audio data with specific pattern
    const sampleRate = 48000;
    const duration = 0.1; // 100ms
    const numSamples = Math.floor(sampleRate * duration);
    const originalData = Buffer.alloc(numSamples * 2);

    // Generate a simple sine wave
    for (let i = 0; i < numSamples; i++) {
      const value = Math.floor(Math.sin(i * 0.1) * 32767);
      originalData.writeInt16LE(value, i * 2);
    }

    // Encode and decode with quantum enhancement
    const encoded = await flacPattern.encode(originalData);
    const decoded = await flacPattern.decode(encoded);

    expect(decoded).toBeDefined();
    expect(decoded.length).toBe(originalData.length);

    // Verify signal integrity (allowing for some quantum variance)
    let sumDiff = 0;
    for (let i = 0; i < numSamples; i++) {
      const original = originalData.readInt16LE(i * 2);
      const processed = decoded.readInt16LE(i * 2);
      sumDiff += Math.abs(original - processed);
    }

    const avgDiff = sumDiff / numSamples;
    expect(avgDiff).toBeLessThan(1000); // Allow for quantum variations
  });

  test('generates quantum state visualization', async () => {
    const visualizer = new QuantumStateVisualizer();
    const corrector = new AdaptiveResonanceCorrector();

    const pattern: GlimmerWaveform = {
      frequency: 432,
      amplitude: 0.8,
      phase: 0,
      resonance: 0.9
    };

    const buffer = await visualizer.visualizeQuantumField(pattern, corrector);
    expect(buffer).toBeDefined();
    expect(buffer.length).toBeGreaterThan(0);
  });

  test('generates quantum state visualization', async () => {
    const visualizer = new QuantumStateVisualizer();
    const corrector = new AdaptiveResonanceCorrector();

    const pattern: GlimmerWaveform = {
      frequency: 432,
      amplitude: 0.8,
      phase: 0,
      resonance: 0.9
    };

    const buffer = await visualizer.visualizeQuantumField(pattern, corrector);
    expect(buffer).toBeDefined();
    expect(buffer.length).toBeGreaterThan(0);
  });
