import { readFileSync, writeFileSync } from 'fs';

const file = readFileSync('samples/generate_viz.ts', 'utf8');

// Fix the initializeCanvas method
const fixedInitialize = file.replace(
  /private initializeCanvas\(\): void {[\s\S]*?this\.ctx\.restore\(\);/,
  `private initializeCanvas(): void {
    this.ctx.save();
    // Clear with transparency
    this.ctx.clearRect(0, 0, this.width, this.height);
    // Set dark background
    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);
    gradient.addColorStop(0, "#000033");
    gradient.addColorStop(1, "#000066");
    this.ctx.fillStyle = gradient;
    this.ctx.fillRect(0, 0, this.width, this.height);
    this.ctx.restore();`
);

// Fix the clearCanvas method
const fixedBoth = fixedInitialize.replace(
  /private clearCanvas\(\): void {[\s\S]*?this\.ctx\.restore\(\);/,
  `private clearCanvas(): void {
    this.ctx.save();
    this.ctx.clearRect(0, 0, this.width, this.height);
    const gradient = this.ctx.createLinearGradient(0, 0, 0, this.height);
    gradient.addColorStop(0, "#000033");
    gradient.addColorStop(1, "#000066");
    this.ctx.fillStyle = gradient;
    this.ctx.fillRect(0, 0, this.width, this.height);
    this.ctx.restore();`
);

writeFileSync('samples/generate_viz.ts', fixedBoth);
console.log('✧ TypeScript fixes applied');
