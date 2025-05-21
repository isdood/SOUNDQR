import { GlimmerMetadata } from "../metadata/types";
import { FLACDecoder, FLACEncoder } from "../codec/FLACCodec";
import { randomBytes } from "crypto";

export class SampleProcessor {
    private readonly glimmerConfig = {
        resonance: 0.98,
        temporalSync: true,
        patternFidelity: 0.99,
        sampleRate: 48000,
        bitDepth: 24
    };

    constructor(
        private readonly flacDecoder: FLACDecoder,
        private readonly flacEncoder: FLACEncoder
    ) {}

    async createTestFLACWithID3(): Promise<Buffer> {
        const sampleData = await this.generateQuantumSample();
        const metadata = this.createID3Metadata();
        return this.flacEncoder.encode(sampleData, metadata);
    }

    async createTestFLACWithVorbis(): Promise<Buffer> {
        const sampleData = await this.generateQuantumSample();
        const metadata = this.createVorbisMetadata();
        return this.flacEncoder.encode(sampleData, metadata);
    }

    private async generateQuantumSample(): Promise<Buffer> {
        const sampleLength = this.glimmerConfig.sampleRate;
        const buffer = Buffer.alloc(sampleLength * 6); // 24-bit stereo

        for (let i = 0; i < sampleLength; i++) {
            const time = i / this.glimmerConfig.sampleRate;
            const frequency = 440 * (1 + (randomBytes(1)[0] / 256 - 0.5) * 0.01);
            const value = Math.sin(2 * Math.PI * frequency * time);

            // Scale to 24-bit range with headroom
            const sample = Math.floor(value * 4194304);
            const clampedSample = Math.max(-8388608, Math.min(8388607, sample));
            const sampleBytes = Buffer.alloc(3);
            sampleBytes.writeIntBE(clampedSample, 0, 3);

            buffer.set(sampleBytes, i * 6);     // Left channel
            buffer.set(sampleBytes, i * 6 + 3); // Right channel
        }

        return buffer;
    }

    private createID3Metadata(): Buffer {
        return Buffer.from(`
            {
                "title": "✧ Quantum Resonance Suite",
                "artist": "STARWEAVE",
                "album": "GLIMMER Patterns Vol. 3",
                "year": 2025,
                "genre": "Quantum",
                "QUANTUM_ID": "${randomBytes(8).toString("hex")}",
                "GLIMMER": true
            }
        `);
    }

    private createVorbisMetadata(): Buffer {
        return Buffer.from(`
            {
                "title": "Quantum Resonance Sample",
                "artist": "STARWEAVE",
                "album": "GLIMMER Patterns",
                "year": 2025,
                "QUANTUM_SIGNATURE": "${randomBytes(8).toString("hex")}",
                "GLIMMER": true
            }
        `);
    }
}
