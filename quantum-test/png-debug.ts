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
