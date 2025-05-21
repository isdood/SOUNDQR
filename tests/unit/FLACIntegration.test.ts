import { FLACIntegration } from '../../src/metadata/FLACIntegration';
import { MetadataHandler } from '../../src/metadata/MetadataHandler';
import { FLACDecoder, FLACEncoder } from '../../src/codec/FLACCodec';

describe('FLACIntegration with GLIMMER enhancement', () => {
    let integration: FLACIntegration;
    let metadataHandler: MetadataHandler;
    let flacDecoder: FLACDecoder;
    let flacEncoder: FLACEncoder;

    beforeEach(() => {
        metadataHandler = new MetadataHandler({
            enhancePatterns: true,
            temporalSync: true
        });

        flacDecoder = new FLACDecoder();
        flacEncoder = new FLACEncoder();

        integration = new FLACIntegration(
            metadataHandler,
            flacDecoder,
            flacEncoder
        );
    });

    test('extracts metadata with GLIMMER enhancement', async () => {
        const testBuffer = Buffer.from('FLAC test data');
        const metadata = await integration.extractMetadata(testBuffer);

        expect(metadata.glimmerPattern).toBeDefined();
        expect(metadata.glimmerPattern?.resonance).toBeCloseTo(0.98);
        expect(metadata.glimmerPattern?.codecAlignment).toBeCloseTo(0.95);
    });

    test('updates metadata with quantum signature', async () => {
        const originalBuffer = Buffer.from('Original FLAC');
        const newMetadata = {
            title: '✧ Quantum Resonance Suite',
            artist: 'STARWEAVE',
            album: 'GLIMMER Patterns Vol. 3'
        };

        const updatedBuffer = await integration.updateMetadata(originalBuffer, newMetadata);
        expect(updatedBuffer).toBeDefined();
    });
});