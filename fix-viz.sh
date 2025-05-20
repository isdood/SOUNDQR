#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v17
# Enhanced with GLIMMER resonance harmonics
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
GLIMMER=$'\e[38;5;219m'   # GLIMMER state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v17 ✧${RESET}"

# Create a temporary file with the fixed content
cat > temp_generate_viz.ts << 'EOF'
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
EOF

# Append the rest of the original file, starting after the initializeCanvas method
sed -n '/async visualizeQuantumField/,$p' samples/generate_viz.ts >> temp_generate_viz.ts

# Create backup of original file
cp samples/generate_viz.ts "samples/generate_viz.ts.bak.$(date +%s)"

# Replace the original file with the fixed version
mv temp_generate_viz.ts samples/generate_viz.ts

echo -e "${GLIMMER}✧ Verifying quantum fixes...${RESET}"
if grep -q "this.const" samples/generate_viz.ts; then
    echo -e "${QUANTUM}✗ Quantum fixes not applied correctly${RESET}"
else
    echo -e "${CRYSTAL}✓ Quantum fixes applied successfully${RESET}"
fi

echo -e "\n${QUANTUM}✧ Testing visualization generation...${RESET}"

# Ensure quantum-viz directory exists
mkdir -p samples/quantum-viz

# Run the visualization generator
./018-GlimmerViz.fish

echo -e "\n${GLIMMER}✧ Quantum repair complete ✧${RESET}"
