import { createCanvas } from "canvas";

interface GlimmerWaveform {
  frequency: number;
  amplitude: number;
  phase: number;
  resonance: number;
}

class QuantumStateVisualizer {
  private canvas: any;
  private ctx: any;
  private readonly width = 800;
  private readonly height = 400;

  constructor() {
    this.canvas = createCanvas(this.width, this.height);
    this.ctx = this.canvas.getContext("2d");
    this.initializeCanvas();
  }

  private initializeCanvas(): void {
    this.ctx.fillStyle = "#000033";
    this.ctx.fillRect(0, 0, this.width, this.height);
  }

  async visualizeQuantumField(pattern: GlimmerWaveform): Promise<Buffer> {
    this.clearCanvas();

    // Generate unique quantum field based on frequency
    const quantumValues = new Float32Array(512);
    for (let i = 0; i < quantumValues.length; i++) {
      const timePhase = (i / quantumValues.length) * pattern.phase;
      const frequencyComponent = Math.sin(2 * Math.PI * pattern.frequency * timePhase / 1000);
      const quantumComponent = Math.random() * 2 - 1;
      quantumValues[i] = (frequencyComponent * 0.7 + quantumComponent * 0.3) * pattern.amplitude;
    }

    // Create GLIMMER baseline glow
    const baseGlow = this.ctx.createLinearGradient(0, 0, 0, this.height);
    baseGlow.addColorStop(0, `rgba(147, 219, 251, ${pattern.amplitude * 0.1})`);
    baseGlow.addColorStop(0.5, `rgba(221, 154, 255, ${pattern.amplitude * 0.15})`);
    baseGlow.addColorStop(1, `rgba(147, 219, 251, ${pattern.amplitude * 0.1})`);

    this.ctx.fillStyle = baseGlow;
    this.ctx.fillRect(0, 0, this.width, this.height);

    // Draw primary quantum pattern
    this.ctx.beginPath();
    this.ctx.strokeStyle = `rgba(147, 219, 251, ${pattern.amplitude * 0.8})`;
    this.ctx.lineWidth = 2;

    for (let i = 0; i < quantumValues.length; i++) {
      const x = (i / quantumValues.length) * this.width;
      const y = (quantumValues[i] + 1) * this.height / 2;

      if (i === 0) {
        this.ctx.moveTo(x, y);
      } else {
        this.ctx.lineTo(x, y);
      }
    }

    this.ctx.stroke();

    // Add resonance harmonics
    this.ctx.beginPath();
    this.ctx.strokeStyle = `rgba(221, 154, 255, ${pattern.amplitude * 0.4})`;
    this.ctx.lineWidth = 1;

    for (let i = 0; i < quantumValues.length; i++) {
      const x = (i / quantumValues.length) * this.width;
      const harmonic = Math.sin(2 * Math.PI * pattern.frequency * 2 * (i / quantumValues.length));
      const y = this.height/2 + harmonic * this.height/4 * pattern.amplitude * pattern.resonance;

      if (i === 0) {
        this.ctx.moveTo(x, y);
      } else {
        this.ctx.lineTo(x, y);
      }
    }

    this.ctx.stroke();

    // Add GLIMMER effects
    this.addGlimmerEffects(pattern);

    // Add frequency information
    this.ctx.fillStyle = "#FFFFFF";
    this.ctx.font = "16px Arial";
    this.ctx.fillText(
      `⚡ ${pattern.frequency}Hz | ✧ ${(pattern.amplitude * 100).toFixed(0)}% | ⚛ ${(pattern.resonance * 100).toFixed(0)}%`,
      10, 25
    );

    return this.canvas.toBuffer("image/png");
  }

  private addGlimmerEffects(pattern: GlimmerWaveform): void {
    // Create quantum interference pattern
    for (let i = 0; i < 5; i++) {
      const gradient = this.ctx.createRadialGradient(
        this.width * Math.random(),
        this.height * Math.random(),
        0,
        this.width * Math.random(),
        this.height * Math.random(),
        this.height * 0.3
      );

      gradient.addColorStop(0, `rgba(147, 219, 251, ${pattern.amplitude * 0.15})`);
      gradient.addColorStop(0.5, `rgba(221, 154, 255, ${pattern.amplitude * 0.1})`);
      gradient.addColorStop(1, "rgba(147, 219, 251, 0)");

      this.ctx.fillStyle = gradient;
      this.ctx.fillRect(0, 0, this.width, this.height);
    }
  }

  private clearCanvas(): void {
    this.ctx.fillStyle = "#000033";
    this.ctx.fillRect(0, 0, this.width, this.height);

    // Add subtle background grid
    this.ctx.strokeStyle = "rgba(147, 219, 251, 0.1)";
    this.ctx.lineWidth = 0.5;

    for (let i = 0; i < this.width; i += 20) {
      this.ctx.beginPath();
      this.ctx.moveTo(i, 0);
      this.ctx.lineTo(i, this.height);
      this.ctx.stroke();
    }

    for (let i = 0; i < this.height; i += 20) {
      this.ctx.beginPath();
      this.ctx.moveTo(0, i);
      this.ctx.lineTo(this.width, i);
      this.ctx.stroke();
    }
  }
}

async function generateSamples() {
  const visualizer = new QuantumStateVisualizer();

  // Generate samples for different frequencies and intensities
  const frequencies = [432, 528, 639, 741];
  const intensities = [0.3, 0.6, 0.9];

  console.log("\x1b[36m✧ Generating quantum field visualizations...\x1b[0m");

  for (const freq of frequencies) {
    for (const intensity of intensities) {
      const pattern = {
        frequency: freq,
        amplitude: intensity,
        phase: Math.random() * Math.PI * 2,
        resonance: 0.8
      };

      const buffer = await visualizer.visualizeQuantumField(pattern);

      const fs = await import("fs/promises");
      const filename = `quantum_${freq}hz_${(intensity * 100).toFixed(0)}pct.png`;
      await fs.writeFile(`samples/quantum-viz/${filename}`, buffer);
      console.log(`\x1b[38;5;219m✧ Generated ${filename}\x1b[0m`);
    }
  }

  console.log("\x1b[35m✧ Generating temporal evolution sequence...\x1b[0m");

  const pattern = {
    frequency: 432,
    amplitude: 0.8,
    phase: 0,
    resonance: 0.9
  };

  for (let t = 0; t < 10; t++) {
    pattern.phase = (t / 10) * Math.PI * 2;
    const buffer = await visualizer.visualizeQuantumField(pattern);
    const filename = `temporal_${t.toString().padStart(2, "0")}.png`;

    const fs = await import("fs/promises");
    await fs.writeFile(`samples/quantum-viz/${filename}`, buffer);
    console.log(`\x1b[38;5;123m✧ Generated ${filename}\x1b[0m`);
  }
}

generateSamples().catch(console.error);
