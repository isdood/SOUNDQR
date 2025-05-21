import { MetadataHandler } from '../../src/metadata/MetadataHandler';
import { GlimmerMetadata } from '../../src/metadata/types';

describe('MetadataHandler with GLIMMER enhancement', () => {
    let handler: MetadataHandler;

    beforeEach(() => {
        handler = new MetadataHandler({
            enhancePatterns: true,
            temporalSync: true
        });
    });

    test('extracts ID3 tags with GLIMMER enhancement', async () => {
        const testBuffer = Buffer.from('ID3test');
        const metadata = await handler.extractID3(testBuffer);

        expect(metadata).toBeDefined();
    });

    test('processes Vorbis comments', async () => {
        const testBuffer = Buffer.from('vorbistest');
        const metadata = await handler.extractVorbis(testBuffer);

        expect(metadata).toBeDefined();
    });
});
