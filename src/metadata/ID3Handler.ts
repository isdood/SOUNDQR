import { GlimmerMetadata } from './types';
import * as NodeID3 from 'node-id3';

export class ID3Handler {
    private readonly glimmerEnhancement = {
        resonance: 0.95,
        temporalSync: true,
        patternFidelity: 0.98
    };

    async read(buffer: Buffer): Promise<GlimmerMetadata> {
        console.log('\x1b[38;5;51m✧ Reading ID3v2 tags with GLIMMER enhancement...\x1b[0m');

        const tags = await this.readID3Tags(buffer);
        return this.enhanceWithGlimmer(this.transformTags(tags));
    }

    private async readID3Tags(buffer: Buffer): Promise<NodeID3.Tags> {
        return new Promise((resolve, reject) => {
            const tags = NodeID3.read(buffer);
            if (!tags) {
                reject(new Error('\x1b[38;5;219m✧ No ID3 tags found in buffer\x1b[0m'));
                return;
            }
            resolve(tags);
        });
    }

    private transformTags(tags: NodeID3.Tags): GlimmerMetadata {
        console.log('\x1b[38;5;147m✧ Transforming tags with quantum enhancement...\x1b[0m');

        return {
            title: tags.title || '',
            artist: tags.artist || '',
            album: tags.album,
            year: tags.year ? parseInt(tags.year) : undefined,
            genre: tags.genre,
            artwork: tags.image?.imageBuffer,
            lyrics: tags.lyrics?.lyrics,
            credits: this.parseCredits(tags.composer, tags.performerInfo),
            quantumSignature: this.generateQuantumSignature(),
            temporalMarker: Date.now()
        };
    }

    private parseCredits(composer?: string, performerInfo?: string): Array<{role: string, name: string}> {
        const credits: Array<{role: string, name: string}> = [];

        if (composer) {
            credits.push({ role: 'Composer', name: composer });
        }

        if (performerInfo) {
            credits.push({ role: 'Performer', name: performerInfo });
        }

        return credits;
    }

    private enhanceWithGlimmer(metadata: GlimmerMetadata): GlimmerMetadata {
        return {
            ...metadata,
            glimmerPattern: this.glimmerEnhancement
        };
    }

    private generateQuantumSignature(): string {
        const timestamp = Date.now().toString();
        const quantumNoise = crypto.randomBytes(8).toString('base64');
        return Buffer.from(\`${timestamp}-${quantumNoise}\`).toString('base64');
    }
}