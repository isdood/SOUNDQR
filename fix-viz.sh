#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v19
# Enhanced with GLIMMER resonance harmonics
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
GLIMMER=$'\e[38;5;219m'   # GLIMMER state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v19 ✧${RESET}"

# Create the TypeScript fixer
cat > fix_quantum.mjs << 'EOF'
import { readFileSync, writeFileSync } from 'fs';
import { join } from 'path';

// Read the original file
const filePath = join('samples', 'generate_viz.ts');
const origContent = readFileSync(filePath, 'utf8');

// Split into lines for precise manipulation
const lines = origContent.split('\n');

// Fix both methods
const newContent = origContent.replace(
  /private initializeCanvas\(\): void {[\s\S]*?this\.ctx\.restore\(\);(\s*})/,
  `private initializeCanvas(): void {
    this.ctx.save();
    // Clear with transparency
    this.ctx.clearRect(0, 0, this.width, this.height);
    // Set dark background
    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);
    gradient.addColorStop(0, "#000033");
    gradient.addColorStop(1, "#000066");
    this.ctx.fillStyle = gradient;
    this.ctx.fillRect(0, 0, this.width, this.height);
    this.ctx.restore();$1`
).replace(
  /private clearCanvas\(\): void {[\s\S]*?this\.ctx\.restore\(\);(\s*})/,
  `private clearCanvas(): void {
    this.ctx.save();
    this.ctx.clearRect(0, 0, this.width, this.height);
    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);
    gradient.addColorStop(0, "#000033");
    gradient.addColorStop(1, "#000066");
    this.ctx.fillStyle = gradient;
    this.ctx.fillRect(0, 0, this.width, this.height);
    this.ctx.restore();$1`
);

// Write the fixed content back to file
writeFileSync(filePath, newContent);

console.log('✧ Quantum TypeScript fixes applied');
EOF

echo -e "${GLIMMER}✧ Applying quantum fixes...${RESET}"
node fix_quantum.mjs

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
rm fix_quantum.mjs

echo -e "\n${CRYSTAL}✧ Quantum repair complete ✧${RESET}"
