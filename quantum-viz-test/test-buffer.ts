import { createCanvas } from 'canvas';
import { writeFileSync, statSync } from 'fs';

const debugCanvas = async () => {
    try {
        // Force specific canvas creation
        const width = 400;
        const height = 200;
        console.log(`${QUANTUM}✧ Creating canvas (${width}x${height})...${RESET}`);

        const canvas = createCanvas(width, height);
        const ctx = canvas.getContext('2d');

        // Verify canvas is created
        console.log(`${CRYSTAL}✧ Canvas created with dimensions: ${canvas.width}x${canvas.height}${RESET}`);

        // Clear to known state
        console.log(`${PATTERN}✧ Setting initial state...${RESET}`);
        ctx.fillStyle = '#FF0000'; // Bright red for visibility
        ctx.fillRect(0, 0, width, height);

        // Draw test pattern
        console.log(`${QUANTUM}✧ Drawing test pattern...${RESET}`);
        ctx.strokeStyle = '#FFFFFF';
        ctx.lineWidth = 5;
        ctx.beginPath();
        ctx.moveTo(0, height/2);
        ctx.lineTo(width, height/2);
        ctx.stroke();

        // Get buffer with explicit settings
        console.log(`${CRYSTAL}✧ Creating PNG buffer...${RESET}`);
        const pngBuffer = canvas.toBuffer('image/png');
        console.log(`${PATTERN}✧ Buffer created: ${pngBuffer.length} bytes${RESET}`);

        // Write test files
        const testFile = 'quantum-buffer-test.png';
        writeFileSync(testFile, pngBuffer);
        const fileSize = statSync(testFile).size;

        // Write debug data
        const debugInfo = `
STARWEAVE Buffer Analysis:
- Canvas: ${width}x${height}
- Buffer size: ${pngBuffer.length} bytes
- File size: ${fileSize} bytes
- First bytes: ${pngBuffer.slice(0, 16).toString('hex')}
`;
        writeFileSync('buffer-debug.txt', debugInfo);

        return { width, height, bufferSize: pngBuffer.length, fileSize };
    } catch (error) {
        console.error(`${PATTERN}✗ Canvas error:${RESET}`, error);
        return null;
    }
};

// Execute buffer test
debugCanvas().then(result => {
    if (result) {
        console.log(`${QUANTUM}✧ Test complete:${RESET}`);
        console.log(`${CRYSTAL}• Canvas: ${result.width}x${result.height}${RESET}`);
        console.log(`${PATTERN}• Buffer: ${result.bufferSize} bytes${RESET}`);
        console.log(`${QUANTUM}• File: ${result.fileSize} bytes${RESET}`);
    }
}).catch(console.error);
