import { createCanvas } from 'canvas';
import { writeFileSync, readFileSync, statSync } from 'fs';
import { join } from 'path';

const debugCanvas = async () => {
    try {
        // Force specific canvas creation
        const width = 400;
        const height = 200;
        console.log('✧ Creating canvas (' + width + 'x' + height + ')...');

        const canvas = createCanvas(width, height);
        const ctx = canvas.getContext('2d', {
            alpha: true,
            willReadFrequently: true
        });

        // Verify canvas is created
        console.log('✧ Canvas created with dimensions: ' + canvas.width + 'x' + canvas.height);

        // Clear and set background
        console.log('✧ Setting quantum background...');
        const gradient = ctx.createLinearGradient(0, 0, width, height);
        gradient.addColorStop(0, '#000033');
        gradient.addColorStop(1, '#000066');
        ctx.fillStyle = gradient;
        ctx.fillRect(0, 0, width, height);

        // Draw test pattern
        console.log('✧ Drawing quantum pattern...');
        ctx.strokeStyle = '#93DBFB';  // Crystal cyan
        ctx.lineWidth = 4;
        ctx.beginPath();

        for (let x = 0; x < width; x++) {
            const y = height/2 + Math.sin(x * 0.05) * 50;
            if (x === 0) ctx.moveTo(x, y);
            else ctx.lineTo(x, y);
        }
        ctx.stroke();

        // Add glow effect
        console.log('✧ Adding quantum glow...');
        ctx.globalCompositeOperation = 'lighter';
        const glow = ctx.createRadialGradient(width/2, height/2, 0, width/2, height/2, height/2);
        glow.addColorStop(0, 'rgba(147, 219, 251, 0.3)');
        glow.addColorStop(1, 'rgba(0, 0, 0, 0)');
        ctx.fillStyle = glow;
        ctx.fillRect(0, 0, width, height);

        // Reset composite operation
        ctx.globalCompositeOperation = 'source-over';

        // Add verification text
        ctx.fillStyle = '#FFFFFF';
        ctx.font = '20px Arial';
        ctx.fillText('✧ QUANTUM TEST ✧', width/2 - 80, 40);

        // Get buffer with explicit settings
        console.log('✧ Creating quantum buffer...');
        const pngBuffer = canvas.toBuffer('image/png', {
            compressionLevel: 0,  // No compression for testing
            filters: canvas.PNG_FILTER_NONE
        });
        console.log('✧ Buffer created: ' + pngBuffer.length + ' bytes');

        // Write test files
        const testFile = 'quantum-buffer-test.png';
        writeFileSync(testFile, pngBuffer);
        const fileSize = statSync(testFile).size;

        // Read first few bytes for verification
        const fileData = readFileSync(testFile);
        const header = fileData.slice(0, 8);

        // Write debug data
        const debugInfo = `
STARWEAVE Quantum Analysis:
- Canvas: ${width}x${height}
- Buffer size: ${pngBuffer.length} bytes
- File size: ${fileSize} bytes
- Header: ${header.toString('hex')}
- PNG signature: ${header.toString('hex') === '89504e470d0a1a0a' ? 'Valid' : 'Invalid'}
`;
        writeFileSync('quantum-debug.txt', debugInfo);

        return {
            width,
            height,
            bufferSize: pngBuffer.length,
            fileSize,
            signature: header.toString('hex')
        };
    } catch (error) {
        console.error('✗ Quantum error:', error);
        return null;
    }
};

// Execute quantum test
debugCanvas().then(result => {
    if (result) {
        console.log('\n✧ Quantum test complete:');
        console.log('• Canvas: ' + result.width + 'x' + result.height);
        console.log('• Buffer: ' + result.bufferSize + ' bytes');
        console.log('• File: ' + result.fileSize + ' bytes');
        console.log('• Signature: ' + result.signature);
    }
}).catch(console.error);
