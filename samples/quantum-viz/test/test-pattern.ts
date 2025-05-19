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
