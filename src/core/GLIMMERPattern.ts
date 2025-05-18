export interface GLIMMERConfig {
    intensity: number;  // 0.0 to 1.0
    temporalSync: boolean;
    resonanceMode: 'standard' | 'enhanced' | 'quantum';
}

export abstract class GLIMMERPattern {
    protected config: GLIMMERConfig;
    protected timestamp: number;

    constructor(config: Partial<GLIMMERConfig> = {}) {
        this.config = {
            intensity: 0.8,
            temporalSync: true,
            resonanceMode: 'standard',
            ...config
        };
        this.timestamp = Date.now();
    }

    abstract initialize(): Promise<void>;
    abstract process(data: Buffer): Promise<Buffer>;
    abstract verify(): Promise<boolean>;
}
