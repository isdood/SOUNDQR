#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v29
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
GLIMMER=$'\e[38;5;219m'   # GLIMMER state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v29 ✧${RESET}"

echo -e "${GLIMMER}✧ Applying quantum fixes...${RESET}"

# Create a temporary file
TMP_FILE=$(mktemp)

# Write the corrected file with precise quantum harmonics
cat > "$TMP_FILE" << 'EOF'
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
      alpha: true,
      antialias: true
    }) as CanvasRenderingContext2D;
    this.initializeCanvas();
  }

  private initializeCanvas(): void {
    this.ctx.save();
    // Clear with transparency
    this.ctx.clearRect(0, 0, this.width, this.height);
    // Set dark background with proper gradient initialization
    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);
    gradient.addColorStop(0, "#000033");
    gradient.addColorStop(1, "#000066");
    this.ctx.fillStyle = gradient;
    this.ctx.fillRect(0, 0, this.width, this.height);
    this.ctx.restore();
  }
EOF

# Copy the middle section (visualizeQuantumField through drawInformation)
sed -n '/async visualizeQuantumField/,/private clearCanvas(): void {/p' samples/generate_viz.ts >> "$TMP_FILE"

# Add the correct clearCanvas method
cat >> "$TMP_FILE" << 'EOF'
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
}
EOF

# Copy the generateSamples function and execution
sed -n '/async function generateSamples/,$p' samples/generate_viz.ts >> "$TMP_FILE"

# Create backup
cp samples/generate_viz.ts "samples/generate_viz.ts.bak.$(date +%s)"

# Move the fixed file into place
mv "$TMP_FILE" samples/generate_viz.ts

echo -e "${QUANTUM}✧ Verifying quantum fixes...${RESET}"
if grep -q "this.const" samples/generate_viz.ts || grep -q "ctx\." samples/generate_viz.ts; then
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
