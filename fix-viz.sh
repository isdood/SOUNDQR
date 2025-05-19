#!/bin/bash

# STARWEAVE Visualization Diagnostic Tool v4
# Created: 2025-05-19 23:10:19 UTC
# Author: isdood

# GLIMMER visualization palette
CYAN=$'\e[38;5;51m'
PURPLE=$'\e[38;5;147m'
PINK=$'\e[38;5;219m'
RESET=$'\e[0m'

echo -e "${CYAN}✧ STARWEAVE Visualization Diagnostic Tool v4 ✧${RESET}"

# Create test directories
TEST_DIR="quantum-test"
mkdir -p "$TEST_DIR"

# Create minimal test file with PNG debugging
cat > "$TEST_DIR/png-debug.ts" << 'EOF'
import { createCanvas } from "canvas";
import { writeFileSync } from "fs";

async function debugCanvas() {
    try {
        // Create canvas with explicit pixel format
        const canvas = createCanvas(400, 200, 'png');
        const ctx = canvas.getContext('2d', {
            alpha: true,
            pixelFormat: 'RGBA32'
        });

        // Clear and set background
        ctx.fillStyle = '#000033';
        ctx.fillRect(0, 0, 400, 200);

        // Draw test pattern
        ctx.beginPath();
        ctx.strokeStyle = '#93DBFB';
        ctx.lineWidth = 4;

        for (let x = 0; x < 400; x += 1) {
            const y = 100 + Math.sin(x * 0.05) * 50;
            if (x === 0) ctx.moveTo(x, y);
            else ctx.lineTo(x, y);
        }
        ctx.stroke();

        // Add verification text
        ctx.fillStyle = '#FFFFFF';
        ctx.font = '20px Arial';
        ctx.fillText('GLIMMER Test ✧', 150, 50);

        // Get PNG buffer with explicit settings
        const buffer = canvas.toBuffer('image/png', {
            compressionLevel: 6,
            filters: canvas.PNG_FILTER_NONE,
            resolution: 144,
            palette: false,
            backgroundIndex: 0,
            colorType: 6  // RGBA
        });

        // Write buffer directly
        writeFileSync('quantum-test/test.png', buffer);

        // Write debug info
        const debugInfo = `
PNG Debug Info:
- Buffer size: ${buffer.length} bytes
- Header check: ${buffer.slice(0, 8).toString('hex')}
- IHDR chunk: ${buffer.slice(8, 25).toString('hex')}
- First 50 bytes: ${buffer.slice(0, 50).toString('hex')}
        `;
        writeFileSync('quantum-test/debug.txt', debugInfo);

        console.log(`${debugInfo}`);
        return true;
    } catch (error) {
        console.error('Canvas error:', error);
        return false;
    }
}

debugCanvas();
EOF

# Create minimal package.json
cat > "$TEST_DIR/package.json" << EOF
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

# Function to test PNG generation
test_png_generation() {
    echo -e "${PURPLE}✧ Testing PNG generation...${RESET}"

    cd "$TEST_DIR"

    echo -e "${CYAN}✧ Installing dependencies...${RESET}"
    npm install --quiet

    echo -e "${PINK}✧ Running PNG debug test...${RESET}"
    npx tsx png-debug.ts

    if [ -f "test.png" ]; then
        SIZE=$(stat -f%z "test.png" 2>/dev/null || stat -c%s "test.png")
        echo -e "${CYAN}✓ Test PNG generated (${SIZE} bytes)${RESET}"

        if [ -f "debug.txt" ]; then
            echo -e "${PURPLE}✧ Debug Information:${RESET}"
            cat debug.txt
        fi
    else
        echo -e "${PINK}✗ Failed to generate test PNG${RESET}"
    fi

    cd ..
}

# Function to check file integrity
check_file_integrity() {
    echo -e "${PURPLE}✧ Checking PNG file integrity...${RESET}"

    if [ -d "samples/quantum-viz" ]; then
        for file in samples/quantum-viz/*.png; do
            echo -e "${CYAN}✧ Analyzing: $(basename "$file")${RESET}"
            SIZE=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")

            # Read first few bytes to check PNG signature
            HEADER=$(od -An -tx1 -N8 "$file" 2>/dev/null | tr -d ' \n')

            echo "  • Size: $SIZE bytes"
            echo "  • Header: $HEADER"

            if [ "$HEADER" = "89504e470d0a1a0a" ]; then
                echo -e "${CYAN}  • Valid PNG header${RESET}"
            else
                echo -e "${PINK}  • Invalid PNG header${RESET}"
            fi
        done
    else
        echo -e "${PINK}✗ Visualization directory not found${RESET}"
    fi
}

# Function to apply fixes
apply_fixes() {
    echo -e "${PURPLE}✧ Applying fixes to main script...${RESET}"

    if [ -f "018-GlimmerViz.fish" ]; then
        # Create backup
        cp 018-GlimmerViz.fish 018-GlimmerViz.fish.bak

        # Update canvas initialization
        sed -i.bak 's/createCanvas(this.width, this.height)/createCanvas(this.width, this.height, "png")/' 018-GlimmerViz.fish
        sed -i.bak 's/getContext("2d")/getContext("2d", { alpha: true, pixelFormat: "RGBA32" })/' 018-GlimmerViz.fish

        echo -e "${CYAN}✓ Applied canvas initialization fixes${RESET}"
        echo -e "${PURPLE}✧ Original file backed up as 018-GlimmerViz.fish.bak${RESET}"
    else
        echo -e "${PINK}✗ Main script not found${RESET}"
    fi
}

# Main menu
while true; do
    echo -e "\n${PURPLE}✧ STARWEAVE Diagnostic Menu ✧${RESET}"
    echo -e "${CYAN}1. Test PNG generation${RESET}"
    echo -e "${PURPLE}2. Check file integrity${RESET}"
    echo -e "${PINK}3. Apply fixes${RESET}"
    echo -e "${CYAN}4. Exit${RESET}"

    read -p "$(echo -e ${PURPLE}Enter choice 1-4: ${RESET})" choice

    case $choice in
        1)
            test_png_generation
            ;;
        2)
            check_file_integrity
            ;;
        3)
            apply_fixes
            ;;
        4)
            echo -e "${PURPLE}✧ Closing STARWEAVE diagnostic tool ✧${RESET}"
            exit 0
            ;;
        *)
            echo -e "${PINK}! Invalid choice${RESET}"
            ;;
    esac
done
