import { createCanvas } from "canvas";

async function debugPattern() {
  console.log("\x1b[38;5;147m✧ Initializing canvas...\x1b[0m");
  const canvas = createCanvas(800, 400);
  const ctx = canvas.getContext("2d", { alpha: true });

  console.log("\x1b[38;5;51m✧ Drawing background...\x1b[0m");
  // Navy background
  ctx.fillStyle = "#000033";
  ctx.fillRect(0, 0, 800, 400);

  console.log("\x1b[38;5;219m✧ Adding quantum pattern...\x1b[0m");
  // Draw quantum wave
  ctx.beginPath();
  ctx.strokeStyle = "rgba(147, 219, 251, 0.9)";
  ctx.lineWidth = 3;

  for (let x = 0; x < 800; x++) {
    const y = 200 + Math.sin(x * 0.02) * 100;
    x === 0 ? ctx.moveTo(x, y) : ctx.lineTo(x, y);
  }
  ctx.stroke();

  console.log("\x1b[38;5;147m✧ Adding GLIMMER effects...\x1b[0m");
  // Add glow effect
  const glow = ctx.createRadialGradient(400, 200, 0, 400, 200, 300);
  glow.addColorStop(0, "rgba(147, 219, 251, 0.2)");
  glow.addColorStop(1, "rgba(221, 154, 255, 0)");
  ctx.fillStyle = glow;
  ctx.fillRect(0, 0, 800, 400);

  console.log("\x1b[38;5;51m✧ Adding text overlay...\x1b[0m");
  // Add debug text
  ctx.fillStyle = "#FFFFFF";
  ctx.font = "bold 20px Arial";
  ctx.fillText("✧ GLIMMER Debug Pattern ✧", 300, 50);

  console.log("\x1b[38;5;219m✧ Saving to PNG...\x1b[0m");
  const buffer = canvas.toBuffer("image/png", {
    compressionLevel: 6,
    filters: canvas.PNG_FILTER_NONE,
    resolution: 144
  });

  const fs = await import("fs/promises");
  await fs.writeFile("samples/quantum-viz/debug-pattern.png", buffer);

  console.log("\x1b[38;5;147m✧ Debug pattern generated successfully!\x1b[0m");
  return buffer.length;
}

debugPattern().then(size => {
  console.log(`\x1b[38;5;51m✧ Generated PNG size: ${size} bytes\x1b[0m`);
}).catch(console.error);
