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
}

export class ID3Handler {
    async read(id3Data: Buffer): Promise<GlimmerMetadata> {
        return this.extractMetadata(id3Data);
    }

    private async extractMetadata(id3Data: Buffer): Promise<GlimmerMetadata> {
        const tags = NodeID3.read(id3Data) as ID3Tags;

        return {
            title: tags.title || "Unknown",
            artist: tags.artist || "Unknown",
            album: tags.album,
            year: tags.year ? parseInt(tags.year) : undefined,
            artwork: tags.image?.imageBuffer,
            lyrics: tags.lyrics ? [tags.lyrics] : undefined,
            temporalMarker: Date.now(),
            quantumSignature: this.generateQuantumSignature()
        };
    }

    private generateQuantumSignature(): string {
        const timestamp = Date.now().toString(36);
        const quantumNoise = randomBytes(8).toString("base64");
        return `${timestamp}-${quantumNoise}`;
    }
}
