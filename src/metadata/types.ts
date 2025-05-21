export interface GlimmerMetadata {
    title: string;
    artist: string;
    album?: string;
    year?: number;
    temporalMarker?: number;
    quantumSignature?: string;
    glimmerPattern?: {
        resonance: number;
        temporalSync: boolean;
        patternFidelity: number;
    };
}

export interface GlimmerWaveform {
    frequency: number;
    amplitude: number;
    phase: number;
    harmonics: Array<{
        frequency: number;
        amplitude: number;
        phase: number;
    }>;
}
