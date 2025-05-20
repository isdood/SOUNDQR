import { createCanvas } from 'canvas';
import { writeFileSync } from 'fs';

async function testRenderSteps() {
    console.log('\x1b[38;5;147m✧ Initializing quantum canvas...\x1b[0m');

    // Create canvas with Node-specific settings
    const canvas = createCanvas(400, 200);
    const ctx = canvas.getContext('2d', {
        alpha: false  // Force opaque background
    });

    // Test each rendering step
    const steps = [
        {
            name: 'background',
            render: () => {
                // Solid background first
                ctx.fillStyle = '#000033';
                ctx.fillRect(0, 0, 400, 200);
                return canvas.toBuffer('image/png');
            }
        },
        {
            name: 'gradient',
            render: () => {
                // Add gradient
                const grad = ctx.createLinearGradient(0, 0, 0, 200);
                grad.addColorStop(0, '#000044');
                grad.addColorStop(1, '#000088');
                ctx.fillStyle = grad;
                ctx.fillRect(0, 0, 400, 200);
                return canvas.toBuffer('image/png');
            }
        },
        {
            name: 'wave',
            render: () => {
                // Add wave pattern
                ctx.beginPath();
                ctx.strokeStyle = '#93DBFB';
                ctx.lineWidth = 4;
                for (let x = 0; x < 400; x++) {
                    const y = 100 + Math.sin(x * 0.05) * 50;
                    x === 0 ? ctx.moveTo(x, y) : ctx.lineTo(x, y);
                }
                ctx.stroke();
                return canvas.toBuffer('image/png');
            }
        },
        {
            name: 'glow',
            render: () => {
                // Add glow effect
                ctx.globalCompositeOperation = 'lighter';
                const glow = ctx.createRadialGradient(200, 100, 0, 200, 100, 100);
                glow.addColorStop(0, 'rgba(147, 219, 251, 0.3)');
                glow.addColorStop(1, 'rgba(0, 0, 0, 0)');
                ctx.fillStyle = glow;
                ctx.fillRect(0, 0, 400, 200);
                return canvas.toBuffer('image/png');
            }
        },
        {
            name: 'text',
            render: () => {
                // Add text
                ctx.globalCompositeOperation = 'source-over';
                ctx.fillStyle = '#FFFFFF';
                ctx.font = 'bold 20px Arial';
                ctx.fillText('✧ QUANTUM TEST ✧', 120, 40);
                return canvas.toBuffer('image/png');
            }
        }
    ];

    // Execute each step
    for (const step of steps) {
        console.log(`\x1b[38;5;51m✧ Testing ${step.name} rendering...\x1b[0m`);
        const buffer = step.render();
        writeFileSync(`quantum-${step.name}.png`, buffer);
        console.log(`\x1b[38;5;219m  • Generated: ${buffer.length} bytes\x1b[0m`);
    }

    // Generate final debug info
    const debugInfo = `
✧ STARWEAVE Quantum Render Analysis:
${steps.map(step => {
    const file = `quantum-${step.name}.png`;
    const size = require('fs').statSync(file).size;
    return `• ${step.name}: ${size} bytes`;
}).join('\n')}
`;
    writeFileSync('quantum-debug.txt', debugInfo);

    return steps.length;
}

// Execute test
testRenderSteps()
    .then(steps => console.log(`\x1b[38;5;147m✧ Completed ${steps} quantum render tests\x1b[0m`))
    .catch(error => console.error('\x1b[38;5;219m✗ Quantum render error:', error, '\x1b[0m'));
