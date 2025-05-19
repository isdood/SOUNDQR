#!/bin/bash

# STARWEAVE Quantum Visualization Diagnostic Tool v5
# Created: 2025-05-19 23:15:31 UTC
# Author: isdood

CYAN=$'\e[38;5;51m'
PURPLE=$'\e[38;5;147m'
PINK=$'\e[38;5;219m'
RESET=$'\e[0m'

echo -e "${CYAN}✧ STARWEAVE Quantum Visualization Diagnostic v5 ✧${RESET}"

# Ensure test directory exists with proper permissions
mkdir -p test-quantum/src
cd test-quantum

# Create minimal test case
cat > src/test.ts << 'EOF'
import { createCanvas } from 'canvas';
import { writeFileSync } from 'fs';
import { join } from 'path';

async function testQuantumPattern() {
    console.log("✧ Creating quantum test pattern...");

    // Create canvas with explicit settings
    const canvas = createCanvas(400, 200);
    const ctx = canvas.getContext('2d', {
        alpha: true
    });

    // Force clear the canvas first
    ctx.clearRect(0, 0, 400, 200);

    // Set composite operation to ensure proper layering
    ctx.globalCompositeOperation = 'source-over';

    // Draw background
    console.log("✧ Drawing quantum background...");
    const gradient = ctx.createLinearGradient(0, 0, 0, 200);
    gradient.addColorStop(0, '#000033');
    gradient.addColorStop(1, '#000066');
    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, 400, 200);

    // Draw foreground pattern
    console.log("✧ Generating quantum pattern...");
    ctx.beginPath();
    ctx.strokeStyle = '#93DBFB';
    ctx.lineWidth = 3;
    ctx.moveTo(0, 100);

    for (let x = 0; x < 400; x++) {
        const y = 100 + Math.sin(x * 0.05) * 50;
        ctx.lineTo(x, y);
    }

    // Ensure path is complete
    ctx.stroke();
    ctx.closePath();

    // Add verification text
    ctx.fillStyle = '#FFFFFF';
    ctx.font = '20px Arial';
    ctx.fillText('✧ QUANTUM TEST ✧', 120, 40);

    console.log("✧ Encoding quantum pattern...");

    // Get buffer with explicit settings
    const buffer = canvas.toBuffer('image/png', {
        compressionLevel: 6,
        filters: canvas.PNG_FILTER_NONE,
        resolution: 144,
        colorType: 6
    });

    // Write test pattern
    const testFile = join(process.cwd(), 'quantum-test.png');
    console.log(`✧ Saving to: ${testFile}`);
    writeFileSync(testFile, buffer);

    // Write debug info
    const debugInfo = `
Quantum Pattern Debug Info:
- Buffer size: ${buffer.length} bytes
- First 8 bytes: ${buffer.slice(0, 8).toString('hex')}
- Canvas dimensions: ${canvas.width}x${canvas.height}
- Memory used: ${process.memoryUsage().heapUsed / 1024 / 1024} MB
`;
    writeFileSync('debug.txt', debugInfo);

    return buffer.length;
}

// Execute test
testQuantumPattern()
    .then(size => console.log(`✧ Generated quantum pattern: ${size} bytes`))
    .catch(error => console.error('Quantum pattern error:', error));
EOF

# Create package.json with explicit versions
cat > package.json << EOF
{
  "type": "module",
  "dependencies": {
    "canvas": "^2.11.2"
  },
  "devDependencies": {
    "tsx": "^4.7.0"
  }
}
EOF

# Install dependencies
echo -e "${PURPLE}✧ Installing quantum dependencies...${RESET}"
npm install --quiet

# Run test
echo -e "${CYAN}✧ Generating quantum test pattern...${RESET}"
npx tsx src/test.ts

# Check results
if [ -f "quantum-test.png" ]; then
    SIZE=$(stat -f%z "quantum-test.png" 2>/dev/null || stat -c%s "quantum-test.png")
    echo -e "${PURPLE}✧ Test pattern generated: ${SIZE} bytes${RESET}"

    # Compare with debug info
    if [ -f "debug.txt" ]; then
        echo -e "${CYAN}✧ Quantum Debug Information:${RESET}"
        cat debug.txt
    fi

    # Apply fixes to main script if test succeeds
    if [ "$SIZE" -gt 2323 ]; then
        echo -e "${PURPLE}✧ Applying quantum fixes to main script...${RESET}"
        cd ..
        if [ -f "018-GlimmerViz.fish" ]; then
            cp 018-GlimmerViz.fish 018-GlimmerViz.fish.bak

            # Update the TypeScript part with working pattern
            sed -i.bak "s/this.ctx = canvas.getContext('2d')/this.ctx = canvas.getContext('2d', { alpha: true })/" 018-GlimmerViz.fish
            sed -i.bak "s/this.ctx.fillRect(0, 0, this.width, this.height)/this.ctx.clearRect(0, 0, this.width, this.height); this.ctx.fillRect(0, 0, this.width, this.height)/" 018-GlimmerViz.fish
            sed -i.bak "s/this.canvas.toBuffer('image\/png')/this.canvas.toBuffer('image\/png', { compressionLevel: 6, filters: this.canvas.PNG_FILTER_NONE, colorType: 6 })/" 018-GlimmerViz.fish

            echo -e "${CYAN}✓ Applied quantum pattern fixes${RESET}"
        fi
    fi
else
    echo -e "${PINK}✗ Failed to generate quantum test pattern${RESET}"
fi

echo -e "\n${PURPLE}✧ Quantum diagnostic complete${RESET}"
