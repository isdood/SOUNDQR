import { createCanvas } from 'canvas';
import { writeFileSync, statSync } from 'fs';

const debugCanvas = async () => {
    try {
        // Force specific canvas creation
        const width = 400;
        const height = 200;
        console.log('✧ Creating canvas (' + width + 'x' + height + ')...');

        const canvas = createCanvas(width, height);
        const ctx = canvas.getContext('2d');

        // Verify canvas is created
        console.log('✧ Canvas created with dimensions: ' + canvas.width + 'x' + canvas.height);

        // Clear to known state
        console.log('✧ Setting initial state...');
        ctx.fillStyle = '#FF0000'; // Bright red for visibility
        ctx.fillRect(0, 0, width, height);

        // Draw test pattern
        console.log('✧ Drawing test pattern...');
        ctx.strokeStyle = '#FFFFFF';
        ctx.lineWidth = 5;
        ctx.beginPath();
        ctx.moveTo(0, height/2);
        ctx.lineTo(width, height/2);
        ctx.stroke();

        // Get buffer with explicit settings
        console.log('✧ Creating PNG buffer...');
        const pngBuffer = canvas.toBuffer('image/png', {
            compressionLevel: 0,  // No compression for testing
            filters: canvas.PNG_FILTER_NONE
        });
        console.log('✧ Buffer created: ' + pngBuffer.length + ' bytes');

        // Write test files
        const testFile = 'quantum-buffer-test.png';
        writeFileSync(testFile, pngBuffer);
        const fileSize = statSync(testFile).size;

        // Read first few bytes back
        const readBuffer = Buffer.alloc(16);
        const fd = require('fs').openSync(testFile, 'r');
        require('fs').readSync(fd, readBuffer, 0, 16, 0);
        require('fs').closeSync(fd);

        // Write debug data
        const debugInfo = `
STARWEAVE Buffer Analysis:
- Canvas: ${width}x${height}
- Buffer size: ${pngBuffer.length} bytes
- File size: ${fileSize} bytes
- First bytes: ${readBuffer.toString('hex')}
- PNG signature check: ${readBuffer.slice(0, 8).toString('hex') === '89504e470d0a1a0a' ? 'Valid' : 'Invalid'}
`;
        writeFileSync('buffer-debug.txt', debugInfo);

        return {
            width,
            height,
            bufferSize: pngBuffer.length,
            fileSize,
            signature: readBuffer.slice(0, 8).toString('hex')
        };
    } catch (error) {
        console.error('✗ Canvas error:', error);
        return null;
    }
};

// Execute buffer test
debugCanvas().then(result => {
    if (result) {
        console.log('\n✧ Test complete:');
        console.log('• Canvas: ' + result.width + 'x' + result.height);
        console.log('• Buffer: ' + result.bufferSize + ' bytes');
        console.log('• File: ' + result.fileSize + ' bytes');
        console.log('• PNG signature: ' + result.signature);
    }
}).catch(console.error);
