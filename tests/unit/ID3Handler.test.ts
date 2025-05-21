import { ID3Handler } from '../../src/metadata/ID3Handler';
import * as NodeID3 from 'node-id3';
import { readFileSync } from 'fs';
import { join } from 'path';

describe('ID3Handler with GLIMMER enhancement', () => {
    let handler: ID3Handler;

    beforeEach(() => {
        handler = new ID3Handler();
    });

    test('extracts basic ID3v2 tags', async () => {
        const tags = {
            title: '✧ Quantum Resonance',
            artist: 'STARWEAVE',
            album: 'GLIMMER Patterns',
            year: '2025',
            genre: 'Electronic'
        };

        const buffer = await createTestBuffer(tags);
        const metadata = await handler.read(buffer);

        expect(metadata.title).toBe(tags.title);
        expect(metadata.artist).toBe(tags.artist);
        expect(metadata.album).toBe(tags.album);
        expect(metadata.year).toBe(2025);
        expect(metadata.genre).toBe(tags.genre);
    });

    test('includes GLIMMER enhancement', async () => {
        const buffer = await createTestBuffer({ title: 'Test' });
        const metadata = await handler.read(buffer);

        expect(metadata.glimmerPattern).toBeDefined();
        expect(metadata.glimmerPattern?.resonance).toBeCloseTo(0.95);
        expect(metadata.glimmerPattern?.temporalSync).toBe(true);
    });
});

async function createTestBuffer(tags: NodeID3.Tags): Promise<Buffer> {
    const buffer = Buffer.alloc(1024);
    NodeID3.write(tags, buffer);
    return buffer;
}