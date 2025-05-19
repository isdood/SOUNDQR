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
