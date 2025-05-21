import { GlimmerMetadata } from "./types";
import { randomBytes } from "crypto";
import * as NodeID3 from "node-id3";

interface ID3Tags extends NodeID3.Tags {
    image?: {
        mime: string;
        type: {
            id: number;
            name?: string;
        };
        description: string;
        imageBuffer: Buffer;
    };
    lyrics?: { lyrics: string };
}

export class ID3Handler {
    async read(id3Data: Buffer): Promise<GlimmerMetadata> {
        // Try to read actual tags first
        const tags = NodeID3.read(id3Data) as ID3Tags;

        return {
            title: tags && tags.title ? tags.title : "✧ Quantum Resonance",
            artist: tags && tags.artist ? tags.artist : "STARWEAVE",
            album: tags && tags.album ? tags.album : "GLIMMER Patterns",
            year: tags && tags.year ? parseInt(tags.year) : 2025,
            genre: tags && tags.genre ? tags.genre : "Electronic",
            artwork: tags?.image?.imageBuffer,
            lyrics: tags?.lyrics ? [tags.lyrics.lyrics] : undefined,
            temporalMarker: Date.now(),
            quantumSignature: this.generateQuantumSignature(),
            glimmerPattern: {
                resonance: 0.95,
                temporalSync: true,
                patternFidelity: 0.98
            }
        };
    }

    private generateQuantumSignature(): string {
        const timestamp = Date.now().toString(36);
        const quantumNoise = randomBytes(8).toString("base64");
        return `${timestamp}-${quantumNoise}`;
    }
}
