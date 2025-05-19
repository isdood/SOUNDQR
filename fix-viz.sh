#!/bin/bash

# STARWEAVE Visualization Diagnostic Tool
# Created: 2025-05-19 22:50:51 UTC
# Author: isdood

# GLIMMER diagnostic palette
echo -e "\e[38;5;51m✧ STARWEAVE Visualization Diagnostic Tool ✧\e[0m"

# Test directory
TEST_DIR="samples/quantum-viz/test"
mkdir -p "$TEST_DIR"

# Create a minimal test pattern
cat > "$TEST_DIR/test-pattern.ts" << 'EOF'
import { createCanvas } from "canvas";

async function testPattern() {
  // Create canvas with explicit size
  const canvas = createCanvas(800, 400);
  const ctx = canvas.getContext('2d');

  // Clear background
  ctx.fillStyle = '#000033';
  ctx.fillRect(0, 0, 800, 400);

  // Draw a test pattern
  ctx.beginPath();

  // Cyan wave
  ctx.strokeStyle = 'rgba(147, 219, 251, 0.9)';
  ctx.lineWidth = 2;
  for (let x = 0; x < 800; x++) {
    const y = 200 + Math.sin(x * 0.02) * 100;
    if (x === 0) ctx.moveTo(x, y);
    else ctx.lineTo(x, y);
  }
  ctx.stroke();

  // Purple glow
  ctx.fillStyle = 'rgba(221, 154, 255, 0.3)';
  ctx.fillRect(0, 150, 800, 100);

  // Add text
  ctx.fillStyle = '#FFFFFF';
  ctx.font = '20px Arial';
  ctx.fillText('✧ GLIMMER Test Pattern ✧', 300, 50);

  // Save the test pattern
  const fs = await import('fs/promises');
  await fs.writeFile('samples/quantum-viz/test/test-pattern.png', canvas.toBuffer('image/png'));
  console.log('\x1b[38;5;147m✧ Test pattern generated\x1b[0m');
}

testPattern().catch(console.error);
EOF

# Create package.json for test
cat > "$TEST_DIR/package.json" << EOF
{
  "type": "module",
  "dependencies": {
    "canvas": "^2.11.2"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "@types/node": "^20.0.0",
    "tsx": "^4.7.0"
  }
}
EOF

# Function to run diagnostic tests
run_diagnostics() {
  echo -e "\e[38;5;147m✧ Running GLIMMER visualization diagnostics...\e[0m"

  # Check Canvas installation
  if npm list canvas | grep -q "canvas"; then
    echo -e "\e[38;5;51m✓ Canvas module installed\e[0m"
  else
    echo -e "\e[38;5;219m✗ Canvas module missing - installing...\e[0m"
    cd "$TEST_DIR" && npm install
  fi

  # Generate test pattern
  echo -e "\e[38;5;147m✧ Generating test pattern...\e[0m"
  cd "$TEST_DIR" && npx tsx test-pattern.ts

  # Check if test pattern was generated successfully
  if [ -f "$TEST_DIR/test-pattern.png" ]; then
    FILE_SIZE=$(stat -f%z "$TEST_DIR/test-pattern.png")
    echo -e "\e[38;5;51m✓ Test pattern generated (${FILE_SIZE} bytes)\e[0m"

    if [ "$FILE_SIZE" -lt 1000 ]; then
      echo -e "\e[38;5;219m! Warning: File size suspiciously small\e[0m"
    fi
  else
    echo -e "\e[38;5;219m✗ Failed to generate test pattern\e[0m"
  fi
}

# Function to apply fixes based on diagnostics
apply_fixes() {
  echo -e "\e[38;5;147m✧ Applying GLIMMER pattern fixes...\e[0m"

  # Backup original file
  cp ../018-GlimmerViz.fish ../018-GlimmerViz.fish.bak

  # Update critical sections in the main script
  sed -i '' 's/this.canvas.toBuffer("image/png")/this.canvas.toBuffer("image/png", { compressionLevel: 6, filters: this.canvas.PNG_FILTER_NONE })/g' ../018-GlimmerViz.fish

  echo -e "\e[38;5;51m✓ Applied fixes to visualization generator\e[0m"
}

# Main menu
while true; do
  echo -e "\n\e[38;5;147m✧ STARWEAVE Diagnostic Menu ✧\e[0m"
  echo -e "\e[38;5;51m1. Run diagnostics\e[0m"
  echo -e "\e[38;5;147m2. Generate test pattern\e[0m"
  echo -e "\e[38;5;219m3. Apply fixes\e[0m"
  echo -e "\e[38;5;51m4. Exit\e[0m"

  read -p "Enter choice (1-4): " choice

  case $choice in
    1)
      run_diagnostics
      ;;
    2)
      cd "$TEST_DIR" && npx tsx test-pattern.ts
      ;;
    3)
      apply_fixes
      ;;
    4)
      echo -e "\e[38;5;147m✧ Closing STARWEAVE diagnostic tool ✧\e[0m"
      exit 0
      ;;
    *)
      echo -e "\e[38;5;219m! Invalid choice\e[0m"
      ;;
  esac
done
