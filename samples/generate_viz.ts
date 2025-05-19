import { QuantumStateVisualizer } from '../../src/patterns/QuantumStateVisualizer';
import { AdaptiveResonanceCorrector } from '../../src/patterns/AdaptiveResonanceCorrector';
import { writeFileSync } from 'fs';
import { join } from 'path';

async function generateSamples() {
  const visualizer = new QuantumStateVisualizer();
  const corrector = new AdaptiveResonanceCorrector();

  // Generate samples for different frequencies and intensities
  const frequencies = [432, 528, 639, 741];
  const intensities = [0.3, 0.6, 0.9];

  console.log(`\x1b[36m✧ Generating quantum field visualizations...\x1b[0m`);

  for (const freq of frequencies) {
    for (const intensity of intensities) {
      const pattern = {
        frequency: freq,
        amplitude: intensity,
        phase: Math.random() * Math.PI * 2,
        resonance: 0.8
      };

      // Apply some simulated corrections
      for (let i = 0; i < 10; i++) {
        await corrector.updateCorrection(pattern, Math.random() - 0.5, 0);
      }

      const buffer = await visualizer.visualizeQuantumField(pattern, corrector);
      const filename = `quantum_${freq}hz_${(intensity * 100).toFixed(0)}pct.png`;

      writeFileSync(join('samples', 'quantum-viz', filename), buffer);
      console.log(`\x1b[38;5;219m✧ Generated ${filename}\x1b[0m`);
    }
  }

  // Generate a temporal sequence for 432Hz
  console.log(`\x1b[35m✧ Generating temporal evolution sequence...\x1b[0m`);

  const pattern = {
    frequency: 432,
    amplitude: 0.8,
    phase: 0,
    resonance: 0.9
  };

  for (let t = 0; t < 10; t++) {
    pattern.phase = (t / 10) * Math.PI * 2;
    const buffer = await visualizer.visualizeQuantumField(pattern, corrector);
    const filename = `temporal_${t.toString().padStart(2, '0')}.png`;
    writeFileSync(join('samples', 'quantum-viz', filename), buffer);
    console.log(`\x1b[38;5;123m✧ Generated ${filename}\x1b[0m`);
  }
}

generateSamples().catch(console.error);
