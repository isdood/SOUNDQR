#!/bin/bash

# ✧ STARWEAVE Quantum Visualization Diagnostic Tool v12
CRYSTAL=$'\e[38;5;51m'    # Crystal beam cyan
QUANTUM=$'\e[38;5;147m'   # Quantum field purple
PATTERN=$'\e[38;5;219m'   # Pattern state pink
RESET=$'\e[0m'

echo -e "${CRYSTAL}✧ STARWEAVE Quantum Visualization Diagnostic v12 ✧${RESET}"

# Create minimal test case
cat > quantum-test.ts << 'EOF'
import { createCanvas } from 'canvas';
import { writeFileSync } from 'fs';

class QuantumRenderer {
    private canvas: any;
    private ctx: any;
    private width: number = 400;
    private height: number = 200;

    constructor() {
        this.canvas = createCanvas(this.width, this.height);
        this.ctx = this.canvas.getContext('2d', { alpha: false });
    }

    render() {
        // Clear canvas
        this.ctx.fillStyle = '#000033';
        this.ctx.fillRect(0, 0, this.width, this.height);

        // Create gradient
        const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);
        gradient.addColorStop(0, '#000044');
        gradient.addColorStop(1, '#000088');
        this.ctx.fillStyle = gradient;
        this.ctx.fillRect(0, 0, this.width, this.height);

        // Draw wave
        this.ctx.beginPath();
        this.ctx.strokeStyle = '#93DBFB';
        this.ctx.lineWidth = 4;

        for (let x = 0; x < this.width; x++) {
            const y = this.height/2 + Math.sin(x * 0.05) * 50;
            if (x === 0) this.ctx.moveTo(x, y);
            else this.ctx.lineTo(x, y);
        }
        this.ctx.stroke();

        // Add text
        this.ctx.fillStyle = '#FFFFFF';
        this.ctx.font = '20px Arial';
        this.ctx.fillText('✧ QUANTUM TEST ✧', this.width/2 - 80, 40);

        return this.canvas.toBuffer('image/png', {
            compressionLevel: 0,
            filters: 0
        });
    }
}

// Test the renderer
const test = new QuantumRenderer();
const buffer = test.render();
writeFileSync('quantum-test.png', buffer);
console.log('✧ Generated quantum test pattern');
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

# Run test
echo -e "${CRYSTAL}✧ Running quantum test...${RESET}"
npx tsx quantum-test.ts

# Check results
if [ -f "quantum-test.png" ]; then
    SIZE=$(stat -f%z "quantum-test.png" 2>/dev/null || stat -c%s "quantum-test.png")
    echo -e "\n${QUANTUM}✧ Test Results:${RESET}"
    echo -e "${CRYSTAL}• Generated test pattern: ${SIZE} bytes${RESET}"

    # If test succeeds, update main script
    if [ "$SIZE" -gt 1000 ]; then
        echo -e "\n${QUANTUM}✧ Applying quantum fixes to main script...${RESET}"
        cd ..
        if [ -f "018-GlimmerViz.fish" ]; then
            cp 018-GlimmerViz.fish "018-GlimmerViz.fish.bak.$(date +%s)"

            # Update the visualization code
            GRADIENT_CODE='const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);\n    gradient.addColorStop(0, "#000044");\n    gradient.addColorStop(1, "#000088");\n    this.ctx.fillStyle = gradient;'

            sed -i.bak "s/const ctx = canvas.getContext('2d')/const ctx = canvas.getContext('2d', { alpha: false })/" 018-GlimmerViz.fish
            sed -i.bak "s/this.ctx.fillStyle = \"#000033\"/${GRADIENT_CODE}/" 018-GlimmerViz.fish
            sed -i.bak 's/toBuffer("image\/png")/toBuffer("image\/png", { compressionLevel: 0, filters: 0 })/' 018-GlimmerViz.fish

            echo -e "${CRYSTAL}✓ Applied quantum visualization fixes${RESET}"
        fi
    fi
else
    echo -e "${PATTERN}✗ Quantum test failed${RESET}"
fi

echo -e "\n${QUANTUM}✧ Quantum diagnostic complete ✧${RESET}"
