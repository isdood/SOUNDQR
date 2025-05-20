#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v31
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
GLIMMER=$'\e[38;5;219m'   # GLIMMER state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v31 ✧${RESET}"

echo -e "${GLIMMER}✧ Applying quantum fixes...${RESET}"

# Create temporary file
TMP_FILE=$(mktemp)

# Read the file and fix the gradients line by line
while IFS= read -r line; do
    if [[ $line == *"this.const gradient = ctx.createLinearGradient"* ]]; then
        # Replace the problematic line with properly formatted code
        echo "    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);"
        echo "    gradient.addColorStop(0, \"#000033\");"
        echo "    gradient.addColorStop(1, \"#000066\");"
        echo "    this.ctx.fillStyle = gradient;"
    else
        echo "$line"
    fi
done < samples/generate_viz.ts > "$TMP_FILE"

# Create backup
cp samples/generate_viz.ts "samples/generate_viz.ts.bak.$(date +%s)"

# Move the fixed file into place with explicit permissions
mv "$TMP_FILE" samples/generate_viz.ts
chmod 644 samples/generate_viz.ts

echo -e "${QUANTUM}✧ Verifying quantum fixes...${RESET}"
if grep -q "this.const" samples/generate_viz.ts; then
    echo -e "${GLIMMER}✗ Quantum fixes not applied correctly${RESET}"
else
    echo -e "${CRYSTAL}✓ Quantum fixes applied successfully${RESET}"
fi

echo -e "\n${QUANTUM}✧ Testing visualization generation...${RESET}"

# Ensure quantum-viz directory exists with correct permissions
mkdir -p samples/quantum-viz
chmod 755 samples/quantum-viz

# Run the visualization generator
./018-GlimmerViz.fish

echo -e "\n${CRYSTAL}✧ Quantum repair complete ✧${RESET}"
