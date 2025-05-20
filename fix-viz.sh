#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v16
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
GLIMMER=$'\e[38;5;219m'   # GLIMMER state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v16 ✧${RESET}"

# Create backup
cp samples/generate_viz.ts "samples/generate_viz.ts.bak.$(date +%s)"

echo -e "${GLIMMER}✧ Applying quantum fixes...${RESET}"

# Fix the problematic line in initializeCanvas
sed -i.bak '/this\.const gradient/c\    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);' samples/generate_viz.ts

# Fix the problematic line in clearCanvas
sed -i.bak '187s/.*gradient.*/    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);/' samples/generate_viz.ts

# Add the gradient color stops and fill style
sed -i.bak '/const gradient = this\.ctx\.createLinearGradient/a\    gradient.addColorStop(0, "#000033");\n    gradient.addColorStop(1, "#000066");\n    this.ctx.fillStyle = gradient;' samples/generate_viz.ts

echo -e "${QUANTUM}✧ Verifying quantum fixes...${RESET}"

if grep -q "this.const" samples/generate_viz.ts; then
    echo -e "${GLIMMER}✗ Quantum fixes not applied correctly${RESET}"
else
    echo -e "${CRYSTAL}✓ Quantum fixes applied successfully${RESET}"
fi

echo -e "\n${QUANTUM}✧ Testing visualization generation...${RESET}"

# Create quantum-viz directory if it doesn't exist
mkdir -p samples/quantum-viz

# Run the visualization generator
./018-GlimmerViz.fish

echo -e "\n${CRYSTAL}✧ Quantum repair complete ✧${RESET}"
