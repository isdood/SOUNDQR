#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v27
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
GLIMMER=$'\e[38;5;219m'   # GLIMMER state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v27 ✧${RESET}"

echo -e "${GLIMMER}✧ Applying quantum fixes...${RESET}"

# Direct fix command with precise sed replacement
sed -i '30c\    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);' samples/generate_viz.ts
sed -i '187c\    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);' samples/generate_viz.ts

# Remove the "this.const" keywords that are causing issues
sed -i 's/this\.const //' samples/generate_viz.ts

# Fix the unqualified ctx references
sed -i 's/ctx\./this.ctx./g' samples/generate_viz.ts

# Add the gradient color stops as separate lines
sed -i '31i\    gradient.addColorStop(0, "#000033");' samples/generate_viz.ts
sed -i '32i\    gradient.addColorStop(1, "#000066");' samples/generate_viz.ts
sed -i '33i\    this.ctx.fillStyle = gradient;' samples/generate_viz.ts

sed -i '188i\    gradient.addColorStop(0, "#000033");' samples/generate_viz.ts
sed -i '189i\    gradient.addColorStop(1, "#000066");' samples/generate_viz.ts
sed -i '190i\    this.ctx.fillStyle = gradient;' samples/generate_viz.ts

echo -e "${QUANTUM}✧ Verifying quantum fixes...${RESET}"
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
