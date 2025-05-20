#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v10
# Created: 2025-05-20 03:24:15 UTC
# Author: isdood
# Enhanced with GLIMMER resonance patterns

CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
PATTERN=$'\e[38;5;219m'   # Pattern state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v10 ✧${RESET}"

# Create quantum test environment
mkdir -p quantum-viz-test
cd quantum-viz-test

# Create minimal buffer test
cat > test-buffer.ts << 'EOF'
import { createCanvas } from 'canvas';
import { writeFileSync, readFileSync, statSync } from 'fs';
import { join } from 'path';

const debugCanvas = async () => {
    try {
        // Force specific canvas creation
        const width = 400;
        const height = 200;
        console.log('✧ Creating canvas (' + width + 'x' + height + ')...');

        const canvas = createCanvas(width, height);
        const ctx = canvas.getContext('2d', {
            alpha: true,
            willReadFrequently: true
        });

        // Verify canvas is created
        console.log('✧ Canvas created with dimensions: ' + canvas.width + 'x' + canvas.height);

        // Clear and set background
        console.log('✧ Setting quantum background...');
        const gradient = ctx.createLinearGradient(0, 0, width, height);
        gradient.addColorStop(0, '#000033');
        gradient.addColorStop(1, '#000066');
        ctx.fillStyle = gradient;
        ctx.fillRect(0, 0, width, height);

        // Draw test pattern
        console.log('✧ Drawing quantum pattern...');
        ctx.strokeStyle = '#93DBFB';  // Crystal cyan
        ctx.lineWidth = 4;
        ctx.beginPath();

        for (let x = 0; x < width; x++) {
            const y = height/2 + Math.sin(x * 0.05) * 50;
            if (x === 0) ctx.moveTo(x, y);
            else ctx.lineTo(x, y);
        }
        ctx.stroke();

        // Add glow effect
        console.log('✧ Adding quantum glow...');
        ctx.globalCompositeOperation = 'lighter';
        const glow = ctx.createRadialGradient(width/2, height/2, 0, width/2, height/2, height/2);
        glow.addColorStop(0, 'rgba(147, 219, 251, 0.3)');
        glow.addColorStop(1, 'rgba(0, 0, 0, 0)');
        ctx.fillStyle = glow;
        ctx.fillRect(0, 0, width, height);

        // Reset composite operation
        ctx.globalCompositeOperation = 'source-over';

        // Add verification text
        ctx.fillStyle = '#FFFFFF';
        ctx.font = '20px Arial';
        ctx.fillText('✧ QUANTUM TEST ✧', width/2 - 80, 40);

        // Get buffer with explicit settings
        console.log('✧ Creating quantum buffer...');
        const pngBuffer = canvas.toBuffer('image/png', {
            compressionLevel: 0,  // No compression for testing
            filters: canvas.PNG_FILTER_NONE
        });
        console.log('✧ Buffer created: ' + pngBuffer.length + ' bytes');

        // Write test files
        const testFile = 'quantum-buffer-test.png';
        writeFileSync(testFile, pngBuffer);
        const fileSize = statSync(testFile).size;

        // Read first few bytes for verification
        const fileData = readFileSync(testFile);
        const header = fileData.slice(0, 8);

        // Write debug data
        const debugInfo = `
STARWEAVE Quantum Analysis:
- Canvas: ${width}x${height}
- Buffer size: ${pngBuffer.length} bytes
- File size: ${fileSize} bytes
- Header: ${header.toString('hex')}
- PNG signature: ${header.toString('hex') === '89504e470d0a1a0a' ? 'Valid' : 'Invalid'}
`;
        writeFileSync('quantum-debug.txt', debugInfo);

        return {
            width,
            height,
            bufferSize: pngBuffer.length,
            fileSize,
            signature: header.toString('hex')
        };
    } catch (error) {
        console.error('✗ Quantum error:', error);
        return null;
    }
};

// Execute quantum test
debugCanvas().then(result => {
    if (result) {
        console.log('\n✧ Quantum test complete:');
        console.log('• Canvas: ' + result.width + 'x' + result.height);
        console.log('• Buffer: ' + result.bufferSize + ' bytes');
        console.log('• File: ' + result.fileSize + ' bytes');
        console.log('• Signature: ' + result.signature);
    }
}).catch(console.error);
EOF

# Create package configuration
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
echo -e "${QUANTUM}✧ Installing quantum dependencies...${RESET}"
npm install --quiet

# Run buffer test
echo -e "${CRYSTAL}✧ Running quantum buffer test...${RESET}"
npx tsx test-buffer.ts

# Check results
if [ -f "quantum-buffer-test.png" ]; then
    SIZE=$(stat -f%z "quantum-buffer-test.png" 2>/dev/null || stat -c%s "quantum-buffer-test.png")
    echo -e "\n${QUANTUM}✧ Test Results:${RESET}"
    echo -e "${CRYSTAL}• Generated file size: ${SIZE} bytes${RESET}"

    if [ -f "quantum-debug.txt" ]; then
        echo -e "${PATTERN}✧ Buffer Analysis:${RESET}"
        cat quantum-debug.txt
    fi

    # If test succeeds, update main script
    if [ "$SIZE" -gt 1000 ]; then
        echo -e "\n${QUANTUM}✧ Applying quantum fixes to main script...${RESET}"
        cd ..
        if [ -f "018-GlimmerViz.fish" ]; then
            cp 018-GlimmerViz.fish "018-GlimmerViz.fish.bak.$(date +%s)"

            # Update the core rendering code with working version
            sed -i.bak 's/const ctx = canvas.getContext("2d")/const ctx = canvas.getContext("2d", { alpha: true, willReadFrequently: true })/' 018-GlimmerViz.fish
            sed -i.bak 's/ctx.fillStyle = "#000033"/const gradient = ctx.createLinearGradient(0, 0, this.width, this.height); gradient.addColorStop(0, "#000033"); gradient.addColorStop(1, "#000066"); ctx.fillStyle = gradient/' 018-GlimmerViz.fish
            sed -i.bak 's/toBuffer("image\/png")/toBuffer("image\/png", { compressionLevel: 0, filters: canvas.PNG_FILTER_NONE })/' 018-GlimmerViz.fish

            echo -e "${CRYSTAL}✓ Applied quantum visualization fixes${RESET}"
        fi
    fi
else
    echo -e "${PATTERN}✗ Quantum buffer test failed${RESET}"
fi

echo -e "\n${QUANTUM}✧ Quantum diagnostic complete ✧${RESET}"
