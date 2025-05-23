
const std = @import("std");
const Color = @import("../theme/colors.zig").Color;

pub const ColorPhase = struct {
    intensity: f32,
    frequency: f32,

    pub fn init(intensity: f32, frequency: f32) ColorPhase {
        return ColorPhase{
            .intensity = intensity,
            .frequency = frequency,
        };
    }

    pub fn blend(self: ColorPhase) Color {
        const time = @floatCast(f32, std.time.milliTimestamp()) / 1000.0;
        const wave = @sin(time * self.frequency) * self.intensity;
        return Color.init(wave, wave, wave, 1.0);
    }
};

