import { createCanvas, ImageData } from 'canvas';
import { writeFileSync } from 'fs';

const debugPixels = async () => {
    try {
        // Initialize quantum canvas
        const width = 400;
        const height = 200;
        console.log('✧ Initializing quantum canvas...');

        const canvas = createCanvas(width, height);
        const ctx = canvas.getContext('2d', {
            alpha: false  // Force opaque rendering
        });

        // Create explicit pixel data
        console.log('✧ Creating quantum pixel matrix...');
        const imageData = ctx.createImageData(width, height);
        const data = imageData.data;

        // Fill with test pattern
        console.log('✧ Generating quantum pattern...');
        for (let y = 0; y < height; y++) {
            for (let x = 0; x < width; x++) {
                const i = (y * width + x) * 4;

                // Create a blue gradient background
                const blue = Math.floor((y / height) * 255);
                data[i] = 0;          // R
                data[i + 1] = 0;      // G
                data[i + 2] = blue;   // B
                data[i + 3] = 255;    // A

                // Add a sine wave pattern in white
                const wave = Math.sin((x / width) * Math.PI * 4);
                const waveY = height/2 + wave * 50;
                if (Math.abs(y - waveY) < 2) {
                    data[i] = 255;     // R
                    data[i + 1] = 255; // G
                    data[i + 2] = 255; // B
                }
            }
        }

        // Put pixel data to canvas
        console.log('✧ Materializing quantum pattern...');
        ctx.putImageData(imageData, 0, 0);

        // Add verification text
        ctx.fillStyle = '#FFFFFF';
        ctx.font = '20px Arial';
        ctx.fillText('✧ QUANTUM TEST ✧', width/2 - 80, 40);

        // Get buffer with minimal processing
        console.log('✧ Creating quantum buffer...');
        const pngBuffer = canvas.toBuffer('image/png', {
            compressionLevel: 0,
            filters: 0
        });

        // Write test pattern
        const testFile = 'quantum-pixels.png';
        writeFileSync(testFile, pngBuffer);

        // Write debug info
        const debugInfo = `
STARWEAVE Quantum Pixel Analysis:
- Canvas: ${width}x${height}
- Total pixels: ${width * height}
- Pixel data size: ${data.length} bytes
- Buffer size: ${pngBuffer.length} bytes
- First 32 pixels: ${Array.from(data.slice(0, 32)).join(',')}
`;
        writeFileSync('pixel-debug.txt', debugInfo);

        return {
            width,
            height,
            pixels: data.length,
            buffer: pngBuffer.length
        };
    } catch (error) {
        console.error('✗ Quantum error:', error);
        return null;
    }
};

// Execute quantum test
debugPixels().then(result => {
    if (result) {
        console.log('\n✧ Quantum pixel test complete:');
        console.log(`• Dimensions: ${result.width}x${result.height}`);
        console.log(`• Pixel data: ${result.pixels} bytes`);
        console.log(`• PNG buffer: ${result.buffer} bytes`);
    }
}).catch(console.error);
