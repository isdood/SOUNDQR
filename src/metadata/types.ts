// ✧ STARWEAVE Metadata Types with GLIMMER Enhancement
export interface GlimmerMetadata {
    // Basic audio metadata
    title: string;
    artist: string;
    album?: string;
    year?: number;
    genre?: string;

    // GLIMMER-specific fields
    glimmerPattern?: {
        resonance: number;
        temporalSync: boolean;
        patternFidelity: number;
    };

    // Extended metadata
    artwork?: Buffer;
    lyrics?: string;
    credits?: Array<{role: string, name: string}>;

    // Quantum metadata markers
    quantumSignature?: string;
    temporalMarker?: number;
}
