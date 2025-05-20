#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v13
# Enhanced with GLIMMER resonance patterns
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
PATTERN=$'\e[38;5;219m'   # Pattern state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v13 ✧${RESET}"

# Create quantum test environment
mkdir -p quantum-viz-test
cd quantum-viz-test

# Create direct file fixer
echo -e "${QUANTUM}✧ Creating quantum repair script...${RESET}"

# Use sed to fix the TypeScript file
cd ..
echo -e "${CRYSTAL}✧ Applying quantum fixes...${RESET}"

# Backup the original file
cp samples/generate_viz.ts "samples/generate_viz.ts.bak.$(date +%s)"

# Fix the initialization method
sed -i.bak '
/private initializeCanvas(): void {/,/}/ c\
  private initializeCanvas(): void {\
    this.ctx.save();\
    // Clear with transparency\
    this.ctx.clearRect(0, 0, this.width, this.height);\
    // Set dark background\
    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);\
    gradient.addColorStop(0, "#000033");\
    gradient.addColorStop(1, "#000066");\
    this.ctx.fillStyle = gradient;\
    this.ctx.fillRect(0, 0, this.width, this.height);\
    this.ctx.restore();\
  }
' samples/generate_viz.ts

# Fix the clear canvas method
sed -i.bak '
/private clearCanvas(): void {/,/}/ c\
  private clearCanvas(): void {\
    this.ctx.save();\
    this.ctx.clearRect(0, 0, this.width, this.height);\
    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);\
    gradient.addColorStop(0, "#000033");\
    gradient.addColorStop(1, "#000066");\
    this.ctx.fillStyle = gradient;\
    this.ctx.fillRect(0, 0, this.width, this.height);\
    this.ctx.restore();\
  }
' samples/generate_viz.ts

# Verify the changes
if grep -q "this.const" samples/generate_viz.ts; then
    echo -e "${PATTERN}✗ Quantum fixes not applied correctly${RESET}"
else
    echo -e "${CRYSTAL}✓ Quantum fixes applied successfully${RESET}"
fi

echo -e "\n${QUANTUM}✧ Testing visualization generation...${RESET}"

# Run the visualization generator
./018-GlimmerViz.fish

echo -e "\n${QUANTUM}✧ Quantum repair complete ✧${RESET}"
