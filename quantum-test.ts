import { createCanvas } from 'canvas';
import { writeFileSync } from 'fs';

class QuantumRenderer {
    private canvas: any;
    private ctx: any;
    private width: number = 400;
    private height: number = 200;

    constructor() {
        this.canvas = createCanvas(this.width, this.height);
        this.ctx = this.canvas.getContext('2d', { alpha: false });
    }

    render() {
        // Clear canvas
        this.ctx.fillStyle = '#000033';
        this.ctx.fillRect(0, 0, this.width, this.height);

        // Create gradient
        const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);
        gradient.addColorStop(0, '#000044');
        gradient.addColorStop(1, '#000088');
        this.ctx.fillStyle = gradient;
        this.ctx.fillRect(0, 0, this.width, this.height);

        // Draw wave
        this.ctx.beginPath();
        this.ctx.strokeStyle = '#93DBFB';
        this.ctx.lineWidth = 4;

        for (let x = 0; x < this.width; x++) {
            const y = this.height/2 + Math.sin(x * 0.05) * 50;
            if (x === 0) this.ctx.moveTo(x, y);
            else this.ctx.lineTo(x, y);
        }
        this.ctx.stroke();

        // Add text
        this.ctx.fillStyle = '#FFFFFF';
        this.ctx.font = '20px Arial';
        this.ctx.fillText('✧ QUANTUM TEST ✧', this.width/2 - 80, 40);

        return this.canvas.toBuffer('image/png', {
            compressionLevel: 0,
            filters: 0
        });
    }
}

// Test the renderer
const test = new QuantumRenderer();
const buffer = test.render();
writeFileSync('quantum-test.png', buffer);
console.log('✧ Generated quantum test pattern');
