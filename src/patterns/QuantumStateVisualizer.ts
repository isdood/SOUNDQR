import { createCanvas } from 'canvas';
import { GlimmerWaveform } from './GlimmerResonanceReversal';
import { AdaptiveResonanceCorrector } from './AdaptiveResonanceCorrector';

export class QuantumStateVisualizer {
  private canvas: any;
  private ctx: any;
  private readonly width = 800;
  private readonly height = 400;

  constructor() {
    this.canvas = createCanvas(this.width, this.height);
    this.ctx = this.canvas.getContext('2d');
    this.initializeCanvas();
  }

  private initializeCanvas(): void {
    this.ctx.fillStyle = '#000033';
    this.ctx.fillRect(0, 0, this.width, this.height);
  }

  visualizeQuantumField(
    pattern: GlimmerWaveform,
    corrector: AdaptiveResonanceCorrector
  ): Buffer {
    this.clearCanvas();

    const quantumField = corrector.getQuantumField(pattern);
    const correction = corrector.getCurrentCorrection(pattern);

    // Draw quantum field
    this.ctx.beginPath();
    this.ctx.strokeStyle = `rgba(147, 219, 251, ${correction})`;
    this.ctx.lineWidth = 2;

    for (let i = 0; i < quantumField.length; i++) {
      const x = (i / quantumField.length) * this.width;
      const y = (quantumField[i] + 1) * this.height / 2;

      if (i === 0) {
        this.ctx.moveTo(x, y);
      } else {
        this.ctx.lineTo(x, y);
      }
    }

    this.ctx.stroke();

    // Add GLIMMER effects
    this.addGlimmerEffects(correction);

    // Add info text
    this.ctx.fillStyle = '#FFFFFF';
    this.ctx.font = '14px Arial';
    this.ctx.fillText(
      `Frequency: ${pattern.frequency}Hz | Correction: ${correction.toFixed(3)}`,
      10, 20
    );

    return this.canvas.toBuffer();
  }

  private addGlimmerEffects(intensity: number): void {
    // Add subtle glow effect
    const gradient = this.ctx.createRadialGradient(
      this.width/2, this.height/2, 0,
      this.width/2, this.height/2, this.height
    );

    gradient.addColorStop(0, `rgba(147, 219, 251, ${intensity * 0.2})`);
    gradient.addColorStop(1, 'rgba(147, 219, 251, 0)');

    this.ctx.fillStyle = gradient;
    this.ctx.fillRect(0, 0, this.width, this.height);
  }

  private clearCanvas(): void {
    this.ctx.fillStyle = '#000033';
    this.ctx.fillRect(0, 0, this.width, this.height);
  }
}
