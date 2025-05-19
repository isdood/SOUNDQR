import { createCanvas } from "canvas";
import { writeFile } from "fs/promises";
import { join } from "path";

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

    const debugInfo = `
Canvas Info:
- Width: ${canvas.width}
- Height: ${canvas.height}
- Buffer size: ${buffer.length} bytes
    `;

    // Write files using relative paths
    await writeFile("./test.png", buffer);
    await writeFile("./debug.txt", debugInfo);

    console.log("Test pattern generated successfully!");
    console.log(debugInfo);

  } catch (error) {
    console.error("Error in test pattern generation:", error);
  }
}

testSimplePattern();
