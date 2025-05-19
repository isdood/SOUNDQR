#!/bin/bash

# STARWEAVE Visualization Diagnostic Tool v2
# Created: 2025-05-19 22:58:28 UTC

# Set up pretty console output
CYAN='\e[38;5;51m'
PURPLE='\e[38;5;147m'
PINK='\e[38;5;219m'
RESET='\e[0m'

echo -e "${CYAN}✧ STARWEAVE Visualization Diagnostic Tool v2 ✧${RESET}"

# Create test directory relative to current path
TEST_DIR="viz-test"
mkdir -p "$TEST_DIR"

# Create a minimal test file that will help us verify canvas operations
cat > "$TEST_DIR/simple-test.ts" << 'EOF'
import { createCanvas } from "canvas";

async function testSimplePattern() {
  try {
    console.log("Creating canvas...");
    const canvas = createCanvas(400, 200);
    const ctx = canvas.getContext("2d");

    console.log("Drawing gradient background...");
    // Create gradient
    const gradient = ctx.createLinearGradient(0, 0, 400, 200);
    gradient.addColorStop(0, "#000033");
    gradient.addColorStop(1, "#000066");
    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, 400, 200);

    console.log("Drawing test pattern...");
    // Draw a simple sine wave
    ctx.beginPath();
    ctx.strokeStyle = "#93DBFB";  // Bright cyan
    ctx.lineWidth = 3;

    for (let x = 0; x < 400; x++) {
      const y = 100 + Math.sin(x * 0.05) * 50;
      if (x === 0) ctx.moveTo(x, y);
      else ctx.lineTo(x, y);
    }
    ctx.stroke();

    console.log("Adding text...");
    // Add text
    ctx.fillStyle = "#FFFFFF";
    ctx.font = "20px Arial";
    ctx.fillText("GLIMMER Test ✧", 150, 40);

    console.log("Saving to PNG...");
    // Save with debug info
    const buffer = canvas.toBuffer("image/png", {
      compressionLevel: 6,
      filters: canvas.PNG_FILTER_NONE,
      resolution: 144
    });

    const fs = await import("fs/promises");
    const debugInfo = `
Canvas Info:
- Width: ${canvas.width}
- Height: ${canvas.height}
- Buffer size: ${buffer.length} bytes
    `;
    await fs.writeFile(`${process.cwd()}/${TEST_DIR}/debug.txt`, debugInfo);
    await fs.writeFile(`${process.cwd()}/${TEST_DIR}/test.png`, buffer);

    console.log("Test pattern generated successfully!");
    console.log(debugInfo);

  } catch (error) {
    console.error("Error in test pattern generation:", error);
  }
}

testSimplePattern();
EOF

# Create minimal package.json for test
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

# Function to run simple test
run_simple_test() {
  echo -e "${PURPLE}✧ Running simple canvas test...${RESET}"

  cd "$TEST_DIR"

  echo -e "${CYAN}✧ Installing dependencies...${RESET}"
  npm install

  echo -e "${CYAN}✧ Generating test pattern...${RESET}"
  npx tsx simple-test.ts

  cd ..

  # Check the generated files
  if [ -f "$TEST_DIR/test.png" ]; then
    FILE_SIZE=$(stat -f%z "$TEST_DIR/test.png" 2>/dev/null || stat -c%s "$TEST_DIR/test.png")
    echo -e "${CYAN}✓ Test PNG generated (${FILE_SIZE} bytes)${RESET}"

    # Display debug info
    if [ -f "$TEST_DIR/debug.txt" ]; then
      echo -e "${PURPLE}✧ Debug Information:${RESET}"
      cat "$TEST_DIR/debug.txt"
    fi
  else
    echo -e "${PINK}✗ Failed to generate test PNG${RESET}"
  fi
}

# Function to verify 018-GlimmerViz.fish
check_main_script() {
  echo -e "${PURPLE}✧ Checking main visualization script...${RESET}"

  if [ -f "018-GlimmerViz.fish" ]; then
    echo -e "${CYAN}✓ Found 018-GlimmerViz.fish${RESET}"

    # Check output directory
    if [ -d "samples/quantum-viz" ]; then
      echo -e "${CYAN}✓ Output directory exists${RESET}"

      # Check generated files
      PNG_COUNT=$(find samples/quantum-viz -name "*.png" | wc -l)
      echo -e "${PURPLE}Found ${PNG_COUNT} PNG files${RESET}"

      # Check file sizes
      echo -e "${CYAN}✧ PNG File sizes:${RESET}"
      find samples/quantum-viz -name "*.png" -exec ls -lh {} \;
    else
      echo -e "${PINK}✗ Output directory missing${RESET}"
    fi
  else
    echo -e "${PINK}✗ Main script not found${RESET}"
  fi
}

# Main menu
while true; do
  echo -e "\n${PURPLE}✧ STARWEAVE Diagnostic Menu ✧${RESET}"
  echo -e "${CYAN}1. Run simple canvas test${RESET}"
  echo -e "${PURPLE}2. Check main visualization script${RESET}"
  echo -e "${PINK}3. Exit${RESET}"

  read -p "Enter choice (1-3): " choice

  case $choice in
    1)
      run_simple_test
      ;;
    2)
      check_main_script
      ;;
    3)
      echo -e "${PURPLE}✧ Closing STARWEAVE diagnostic tool ✧${RESET}"
      exit 0
      ;;
    *)
      echo -e "${PINK}! Invalid choice${RESET}"
      ;;
  esac
done
