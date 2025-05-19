import { createCanvas } from 'canvas';
import { writeFileSync } from 'fs';

async function generateQuantumPattern() {
    // Initialize quantum canvas
    const canvas = createCanvas(400, 200, 'image');
    const ctx = canvas.getContext('2d', {
        alpha: true,
        willReadFrequently: true
    });

    // Clear quantum state
    ctx.save();
    ctx.fillStyle = '#000033';
    ctx.fillRect(0, 0, 400, 200);

    // Create quantum gradient
    const gradient = ctx.createLinearGradient(0, 0, 400, 0);
    gradient.addColorStop(0, '#000033');
    gradient.addColorStop(0.5, '#000066');
    gradient.addColorStop(1, '#000033');

    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, 400, 200);

    // Add quantum interference patterns
    ctx.globalCompositeOperation = 'lighter';

    // Primary wave
    ctx.beginPath();
    ctx.strokeStyle = 'rgba(147, 219, 251, 0.8)'; // Crystal cyan
    ctx.lineWidth = 3;
    for (let x = 0; x < 400; x++) {
        const y = 100 + Math.sin(x * 0.05) * 50;
        if (x === 0) ctx.moveTo(x, y);
        else ctx.lineTo(x, y);
    }
    ctx.stroke();

    // Secondary resonance
    ctx.beginPath();
    ctx.strokeStyle = 'rgba(221, 154, 255, 0.5)'; // Quantum purple
    ctx.lineWidth = 2;
    for (let x = 0; x < 400; x++) {
        const y = 100 + Math.cos(x * 0.05) * 30;
        if (x === 0) ctx.moveTo(x, y);
        else ctx.lineTo(x, y);
    }
    ctx.stroke();

    // Add quantum glow
    const glow = ctx.createRadialGradient(200, 100, 0, 200, 100, 200);
    glow.addColorStop(0, 'rgba(147, 219, 251, 0.2)');
    glow.addColorStop(0.5, 'rgba(221, 154, 255, 0.1)');
    glow.addColorStop(1, 'rgba(0, 0, 51, 0)');

    ctx.fillStyle = glow;
    ctx.fillRect(0, 0, 400, 200);

    // Add verification text
    ctx.fillStyle = '#FFFFFF';
    ctx.font = '20px Arial';
    ctx.fillText('✧ QUANTUM COLOR TEST ✧', 100, 40);

    ctx.restore();

    // Save quantum pattern
    const buffer = canvas.toBuffer('image/png', {
        compressionLevel: 6,
        filters: canvas.PNG_FILTER_NONE,
        resolution: 144,
        colorType: 6
    });

    // Write test files
    writeFileSync('quantum-test.png', buffer);

    // Generate debug info
    const debugInfo = `
STARWEAVE Quantum Pattern Analysis:
- Buffer size: ${buffer.length} bytes
- PNG header: ${buffer.slice(0, 8).toString('hex')}
- Canvas dimensions: ${canvas.width}x${canvas.height}
- Memory usage: ${process.memoryUsage().heapUsed / 1024 / 1024} MB
- Color modes:
  • Background: #000033 -> #000066
  • Primary wave: rgba(147, 219, 251, 0.8)
  • Secondary wave: rgba(221, 154, 255, 0.5)
  • Glow effect: Combined radial gradient
`;
    writeFileSync('quantum-debug.txt', debugInfo);

    return { size: buffer.length, header: buffer.slice(0, 8).toString('hex') };
}

// Execute quantum pattern generation
generateQuantumPattern()
    .then(result => {
        console.log('\x1b[38;5;51m✧ Generated quantum pattern:');
        console.log(`  • Size: ${result.size} bytes`);
        console.log(`  • Header: ${result.header}\x1b[0m`);
    })
    .catch(error => console.error('\x1b[38;5;219m✗ Quantum pattern error:', error, '\x1b[0m'));
