import { GLIMMERValidator } from "../../src/validator/GLIMMERValidator";
import { SampleProcessor } from "../../src/processor/SampleProcessor";
import { FLACDecoder, FLACEncoder } from "../../src/codec/FLACCodec";
import * as crypto from "crypto";

describe("GLIMMER Pattern Validator", () => {
    let validator: GLIMMERValidator;
    let sampleProcessor: SampleProcessor;

    beforeEach(() => {
        validator = new GLIMMERValidator();
        sampleProcessor = new SampleProcessor(
            new FLACDecoder(),
            new FLACEncoder()
        );
    });

    describe("Pattern Validation", () => {
        test("validates correct GLIMMER patterns", async () => {
            const sample = await sampleProcessor.createTestFLACWithID3();
            const metadata = {
                temporalMarker: Date.now(),
                quantumSignature: crypto.randomBytes(32).toString("base64"),
                glimmerPattern: {
                    resonance: 0.98,
                    temporalSync: true,
                    patternFidelity: 0.99
                }
            };

            const isValid = await validator.validatePattern(sample, metadata);
            expect(isValid).toBeTruthy();
        });

        test("rejects invalid patterns", async () => {
            const invalidSample = Buffer.from("invalid data");
            const metadata = {
                temporalMarker: Date.now() - 1000 * 60 * 60 * 2, // 2 hours old
                quantumSignature: "invalid",
                glimmerPattern: {
                    resonance: 0.5,
                    temporalSync: false,
                    patternFidelity: 0.5
                }
            };

            const isValid = await validator.validatePattern(invalidSample, metadata);
            expect(isValid).toBeFalsy();
        });
    });
});
