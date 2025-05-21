import { GlimmerMetadata } from './types';
import * as musicMetadata from 'music-metadata';

export class VorbisHandler {
    private readonly glimmerEnhancement = {
        resonance: 0.97,
        temporalSync: true,
        patternFidelity: 0.99
    };

    async read(buffer: Buffer): Promise<GlimmerMetadata> {
        console.log('\x1b[38;5;51m✧ Reading Vorbis comments with GLIMMER enhancement...\x1b[0m');

        const metadata = await this.readVorbisComments(buffer);
        return this.enhanceWithGlimmer(this.transformComments(metadata));
    }

    private async readVorbisComments(buffer: Buffer): Promise<musicMetadata.IAudioMetadata> {
        try {
            return await musicMetadata.parseBuffer(buffer, 'audio/ogg');
        } catch (error) {
            console.error('\x1b[38;5;219m✧ Error reading Vorbis comments:', error, '\x1b[0m');
            throw new Error('Failed to read Vorbis comments');
        }
    }

    private transformComments(metadata: musicMetadata.IAudioMetadata): GlimmerMetadata {
        console.log('\x1b[38;5;147m✧ Transforming Vorbis comments with quantum enhancement...\x1b[0m');

        const common = metadata.common;
        return {
            title: common.title || '',
            artist: common.artist || '',
            album: common.album,
            year: common.year,
            genre: common.genre?.[0],
            artwork: this.extractArtwork(common.picture?.[0]),
            lyrics: common.lyrics?.[0],
            credits: this.parseCredits(common),
            quantumSignature: this.generateQuantumSignature(),
            temporalMarker: Date.now()
        };
    }

    private extractArtwork(picture?: musicMetadata.IPicture): Buffer | undefined {
        return picture?.data;
    }

    private parseCredits(common: musicMetadata.ICommonTagsResult): Array<{role: string, name: string}> {
        const credits: Array<{role: string, name: string}> = [];

        if (common.composer) {
            credits.push({ role: 'Composer', name: common.composer[0] });
        }

        if (common.conductor) {
            credits.push({ role: 'Conductor', name: common.conductor[0] });
        }

        if (common.remixer) {
            credits.push({ role: 'Remixer', name: common.remixer[0] });
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