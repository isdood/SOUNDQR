import { MetadataHandler } from '../../src/metadata/MetadataHandler';
import { ID3Handler } from '../../src/metadata/ID3Handler';
import { VorbisHandler } from '../../src/metadata/VorbisHandler';
import { FLACIntegration } from '../../src/metadata/FLACIntegration';
import { FLACDecoder, FLACEncoder } from '../../src/codec/FLACCodec';
import * as fs from 'fs/promises';
import * as path from 'path';

describe('GLIMMER-Enhanced Metadata Flow', () => {
    let metadataHandler: MetadataHandler;
    let flacIntegration: FLACIntegration;

    beforeAll(async () => {
        await fs.mkdir(path.join(__dirname, 'samples'), { recursive: true });
    });

    beforeEach(() => {
        metadataHandler = new MetadataHandler({
            enhancePatterns: true,
            temporalSync: true
        });

        flacIntegration = new FLACIntegration(
            metadataHandler,
            new FLACDecoder(),
            new FLACEncoder()
        );
    });

    describe('Full Metadata Pipeline', () => {
        test('processes FLAC with ID3 tags', async () => {
            const testData = await createTestFLACWithID3();
            const metadata = await flacIntegration.extractMetadata(testData);

            expect(metadata.glimmerPattern).toBeDefined();
            expect(metadata.glimmerPattern?.resonance).toBeGreaterThan(0.9);
        });
    });
});