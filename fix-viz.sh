#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v28
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
GLIMMER=$'\e[38;5;219m'   # GLIMMER state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v28 ✧${RESET}"

echo -e "${GLIMMER}✧ Applying quantum fixes...${RESET}"

# Create a temporary file
TMP_FILE=$(mktemp)

# Process the file line by line to ensure we capture everything correctly
line_number=0
while IFS= read -r line; do
    line_number=$((line_number + 1))

    if [ $line_number -eq 30 ]; then
        # Replace line 30 with correct gradient initialization
        echo '    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);' >> "$TMP_FILE"
        echo '    gradient.addColorStop(0, "#000033");' >> "$TMP_FILE"
        echo '    gradient.addColorStop(1, "#000066");' >> "$TMP_FILE"
        echo '    this.ctx.fillStyle = gradient;' >> "$TMP_FILE"
    elif [ $line_number -eq 187 ]; then
        # Replace line 187 with correct gradient initialization
        echo '    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);' >> "$TMP_FILE"
        echo '    gradient.addColorStop(0, "#000033");' >> "$TMP_FILE"
        echo '    gradient.addColorStop(1, "#000066");' >> "$TMP_FILE"
        echo '    this.ctx.fillStyle = gradient;' >> "$TMP_FILE"
    elif [ $line_number -eq 31 ] || [ $line_number -eq 32 ] || [ $line_number -eq 33 ] || \
         [ $line_number -eq 188 ] || [ $line_number -eq 189 ] || [ $line_number -eq 190 ]; then
        # Skip the original gradient lines that we're replacing
        continue
    else
        # Keep all other lines as they are
        echo "$line" >> "$TMP_FILE"
    fi
done < samples/generate_viz.ts

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
