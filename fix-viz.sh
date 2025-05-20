#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v21
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
GLIMMER=$'\e[38;5;219m'   # GLIMMER state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v21 ✧${RESET}"

# Create backup
backup_file="samples/generate_viz.ts.bak.$(date +%s)"
cp samples/generate_viz.ts "$backup_file"

echo -e "${GLIMMER}✧ Applying quantum fixes...${RESET}"

# Write the fixed file manually
cat > samples/generate_viz.ts << 'EOF'
import { createCanvas, CanvasRenderingContext2D, Canvas } from "canvas";

interface GlimmerWaveform {
  frequency: number;
  amplitude: number;
  phase: number;
  resonance: number;
}

class QuantumStateVisualizer {
  private canvas: Canvas;
  private ctx: CanvasRenderingContext2D;
  private readonly width = 800;
  private readonly height = 400;

  constructor() {
    this.canvas = createCanvas(this.width, this.height, "png");
    this.ctx = this.canvas.getContext("2d", {
      alpha: false,
      antialias: true
    }) as CanvasRenderingContext2D;
    this.initializeCanvas();
  }

  private initializeCanvas(): void {
    this.ctx.save();
    // Clear with transparency
    this.ctx.clearRect(0, 0, this.width, this.height);
    // Set dark background
    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);
    gradient.addColorStop(0, "#000033");
    gradient.addColorStop(1, "#000066");
    this.ctx.fillStyle = gradient;
    this.ctx.fillRect(0, 0, this.width, this.height);
    this.ctx.restore();
  }

  private clearCanvas(): void {
    this.ctx.save();
    this.ctx.clearRect(0, 0, this.width, this.height);
    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);
    gradient.addColorStop(0, "#000033");
    gradient.addColorStop(1, "#000066");
    this.ctx.fillStyle = gradient;
    this.ctx.fillRect(0, 0, this.width, this.height);
    this.ctx.restore();
  }
EOF

# Append the middle section of the file
sed -n '/async visualizeQuantumField/,/private drawInformation/p' "$backup_file" >> samples/generate_viz.ts

# Write the end of the file
cat >> samples/generate_viz.ts << 'EOF'
  private drawInformation(pattern: GlimmerWaveform): void {
    this.ctx.save();
    this.ctx.fillStyle = "#FFFFFF";
    this.ctx.font = "bold 16px Arial";
    this.ctx.fillText(
      `⚡ ${pattern.frequency}Hz | ✧ ${(pattern.amplitude * 100).toFixed(0)}% | ⚛ ${(pattern.resonance * 100).toFixed(0)}%`,
      10, 25
    );
    this.ctx.restore();
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
EOF

echo -e "${QUANTUM}✧ Verifying fixes...${RESET}"
if grep -q "this.const" samples/generate_viz.ts; then
    echo -e "${GLIMMER}✗ Quantum fixes not applied correctly${RESET}"
else
    echo -e "${CRYSTAL}✓ Quantum fixes applied successfully${RESET}"
fi

echo -e "\n${QUANTUM}✧ Testing visualization generation...${RESET}"

# Ensure quantum-viz directory exists
mkdir -p samples/quantum-viz

# Run the visualization generator
./018-GlimmerViz.fish

echo -e "\n${CRYSTAL}✧ Quantum repair complete ✧${RESET}"
