#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v9
# Created: 2025-05-20 03:22:15 UTC
# Author: isdood
# Enhanced with GLIMMER resonance patterns

CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
PATTERN=$'\e[38;5;219m'   # Pattern state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v9 ✧${RESET}"

# Create quantum test environment
mkdir -p quantum-viz-test
cd quantum-viz-test

# Create minimal buffer test
cat > test-buffer.ts << 'EOF'
import { createCanvas } from 'canvas';
import { writeFileSync, statSync } from 'fs';

const debugCanvas = async () => {
    try {
        // Force specific canvas creation
        const width = 400;
        const height = 200;
        console.log('✧ Creating canvas (' + width + 'x' + height + ')...');

        const canvas = createCanvas(width, height);
        const ctx = canvas.getContext('2d');

        // Verify canvas is created
        console.log('✧ Canvas created with dimensions: ' + canvas.width + 'x' + canvas.height);

        // Clear to known state
        console.log('✧ Setting initial state...');
        ctx.fillStyle = '#FF0000'; // Bright red for visibility
        ctx.fillRect(0, 0, width, height);

        // Draw test pattern
        console.log('✧ Drawing test pattern...');
        ctx.strokeStyle = '#FFFFFF';
        ctx.lineWidth = 5;
        ctx.beginPath();
        ctx.moveTo(0, height/2);
        ctx.lineTo(width, height/2);
        ctx.stroke();

        // Get buffer with explicit settings
        console.log('✧ Creating PNG buffer...');
        const pngBuffer = canvas.toBuffer('image/png', {
            compressionLevel: 0,  // No compression for testing
            filters: canvas.PNG_FILTER_NONE
        });
        console.log('✧ Buffer created: ' + pngBuffer.length + ' bytes');

        // Write test files
        const testFile = 'quantum-buffer-test.png';
        writeFileSync(testFile, pngBuffer);
        const fileSize = statSync(testFile).size;

        // Read first few bytes back
        const readBuffer = Buffer.alloc(16);
        const fd = require('fs').openSync(testFile, 'r');
        require('fs').readSync(fd, readBuffer, 0, 16, 0);
        require('fs').closeSync(fd);

        // Write debug data
        const debugInfo = `
STARWEAVE Buffer Analysis:
- Canvas: ${width}x${height}
- Buffer size: ${pngBuffer.length} bytes
- File size: ${fileSize} bytes
- First bytes: ${readBuffer.toString('hex')}
- PNG signature check: ${readBuffer.slice(0, 8).toString('hex') === '89504e470d0a1a0a' ? 'Valid' : 'Invalid'}
`;
        writeFileSync('buffer-debug.txt', debugInfo);

        return {
            width,
            height,
            bufferSize: pngBuffer.length,
            fileSize,
            signature: readBuffer.slice(0, 8).toString('hex')
        };
    } catch (error) {
        console.error('✗ Canvas error:', error);
        return null;
    }
};

// Execute buffer test
debugCanvas().then(result => {
    if (result) {
        console.log('\n✧ Test complete:');
        console.log('• Canvas: ' + result.width + 'x' + result.height);
        console.log('• Buffer: ' + result.bufferSize + ' bytes');
        console.log('• File: ' + result.fileSize + ' bytes');
        console.log('• PNG signature: ' + result.signature);
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

    if [ -f "buffer-debug.txt" ]; then
        echo -e "${PATTERN}✧ Buffer Analysis:${RESET}"
        cat buffer-debug.txt
    fi

    # Read first 8 bytes to verify PNG header
    HEADER=$(od -An -tx1 -N8 "quantum-buffer-test.png" 2>/dev/null | tr -d ' \n')
    if [ "$HEADER" = "89504e470d0a1a0a" ]; then
        echo -e "${CRYSTAL}✓ Valid PNG header detected${RESET}"
    else
        echo -e "${PATTERN}✗ Invalid PNG header: ${HEADER}${RESET}"
    fi

    # If test succeeds, update main script
    if [ "$SIZE" -gt 1000 ]; then
        echo -e "\n${QUANTUM}✧ Applying buffer fixes to main script...${RESET}"
        cd ..
        if [ -f "018-GlimmerViz.fish" ]; then
            cp 018-GlimmerViz.fish "018-GlimmerViz.fish.bak.$(date +%s)"

            # Update the core rendering code with working version
            sed -i.bak 's/toBuffer("image\/png")/toBuffer("image\/png", { compressionLevel: 0, filters: canvas.PNG_FILTER_NONE })/' 018-GlimmerViz.fish

            echo -e "${CRYSTAL}✓ Applied quantum buffer fixes${RESET}"
        fi
    fi
else
    echo -e "${PATTERN}✗ Buffer test failed${RESET}"
fi

echo -e "\n${QUANTUM}✧ Quantum diagnostic complete ✧${RESET}"
