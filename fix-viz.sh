#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v26
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
GLIMMER=$'\e[38;5;219m'   # GLIMMER state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v26 ✧${RESET}"

echo -e "${GLIMMER}✧ Applying quantum fixes...${RESET}"

# Create a temporary file for sed operations
TMP_FILE=$(mktemp)

# Step 1: Fix the initializeCanvas method with proper this.ctx references
sed '30c\    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);' samples/generate_viz.ts > "$TMP_FILE"
sed -i '31c\    gradient.addColorStop(0, "#000033");' "$TMP_FILE"
sed -i '32c\    gradient.addColorStop(1, "#000066");' "$TMP_FILE"
sed -i '33c\    this.ctx.fillStyle = gradient;' "$TMP_FILE"

# Step 2: Fix the clearCanvas method similarly
sed -i '187c\    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);' "$TMP_FILE"
sed -i '188c\    gradient.addColorStop(0, "#000033");' "$TMP_FILE"
sed -i '189c\    gradient.addColorStop(1, "#000066");' "$TMP_FILE"
sed -i '190c\    this.ctx.fillStyle = gradient;' "$TMP_FILE"

# Create backup
cp samples/generate_viz.ts "samples/generate_viz.ts.bak.$(date +%s)"

# Move the fixed file into place
mv "$TMP_FILE" samples/generate_viz.ts

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
