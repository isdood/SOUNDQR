#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v20
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
GLIMMER=$'\e[38;5;219m'   # GLIMMER state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v20 ✧${RESET}"

# Create backup
cp samples/generate_viz.ts "samples/generate_viz.ts.bak.$(date +%s)"

echo -e "${GLIMMER}✧ Applying quantum fixes...${RESET}"

# Direct method fix - safer approach
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
EOF

# Append the rest of the original file after initializeCanvas
sed -n '/async visualizeQuantumField/,$p' "samples/generate_viz.ts.bak.$(date +%s)" >> samples/generate_viz.ts

# Fix the clearCanvas method directly in the appended content
sed -i 's/this\.const gradient = ctx\.createLinearGradient.*fillStyle = gradient;/const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);\n    gradient.addColorStop(0, "#000033");\n    gradient.addColorStop(1, "#000066");\n    this.ctx.fillStyle = gradient;/' samples/generate_viz.ts

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
