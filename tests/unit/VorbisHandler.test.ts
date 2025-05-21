import { VorbisHandler } from '../../src/metadata/VorbisHandler';
import * as musicMetadata from 'music-metadata';

describe('VorbisHandler with GLIMMER enhancement', () => {
    let handler: VorbisHandler;

    beforeEach(() => {
        handler = new VorbisHandler();
    });

    test('extracts basic Vorbis comments', async () => {
        const testData = {
            common: {
                title: '✧ Quantum Harmony',
                artist: 'STARWEAVE',
                album: 'GLIMMER Patterns Vol. 2',
                year: 2025,
                genre: ['Quantum Electronic']
            },
            format: {
                tagTypes: ['vorbis'],
                duration: 180
            }
        } as musicMetadata.IAudioMetadata;

        const metadata = await handler.read(Buffer.from('test'));

        expect(metadata.glimmerPattern).toBeDefined();
        expect(metadata.glimmerPattern?.resonance).toBeCloseTo(0.97);
        expect(metadata.glimmerPattern?.temporalSync).toBe(true);
    });

    test('handles missing Vorbis comments gracefully', async () => {
        const metadata = await handler.read(Buffer.from('empty'));

        expect(metadata.title).toBe('');
        expect(metadata.artist).toBe('');
        expect(metadata.glimmerPattern).toBeDefined();
    });
});