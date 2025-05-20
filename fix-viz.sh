#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v18
# Enhanced with GLIMMER resonance harmonics
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
GLIMMER=$'\e[38;5;219m'   # GLIMMER state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v18 ✧${RESET}"

# Create the TypeScript fixer
cat > fix_quantum.js << 'EOF'
const fs = require('fs');
const path = require('path');

// Read the original file
const filePath = path.join('samples', 'generate_viz.ts');
const origContent = fs.readFileSync(filePath, 'utf8');

// Split into lines for precise manipulation
const lines = origContent.split('\n');

// Fix the initializeCanvas method
const initStart = lines.findIndex(line => line.includes('private initializeCanvas(): void'));
let initEnd = lines.findIndex((line, idx) => idx > initStart && line.includes('}'));

// Replace the problematic method
const newInitMethod = `  private initializeCanvas(): void {
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
  }`;

// Replace the old method with the new one
lines.splice(initStart, initEnd - initStart + 1, newInitMethod);

// Fix the clearCanvas method
const clearStart = lines.findIndex(line => line.includes('private clearCanvas(): void'));
let clearEnd = lines.findIndex((line, idx) => idx > clearStart && line.includes('}'));

// Replace the problematic method
const newClearMethod = `  private clearCanvas(): void {
    this.ctx.save();
    this.ctx.clearRect(0, 0, this.width, this.height);
    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);
    gradient.addColorStop(0, "#000033");
    gradient.addColorStop(1, "#000066");
    this.ctx.fillStyle = gradient;
    this.ctx.fillRect(0, 0, this.width, this.height);
    this.ctx.restore();
  }`;

// Replace the old method with the new one
lines.splice(clearStart, clearEnd - clearStart + 1, newClearMethod);

// Write the fixed content back to file
fs.writeFileSync(filePath, lines.join('\n'));

console.log('✧ Quantum TypeScript fixes applied');
EOF

echo -e "${GLIMMER}✧ Applying quantum fixes...${RESET}"
node fix_quantum.js

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

# Clean up the temporary file
rm fix_quantum.js

echo -e "\n${CRYSTAL}✧ Quantum repair complete ✧${RESET}"
