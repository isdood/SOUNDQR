//! STARWEAVE Sparkle Effect System
//! Created: 2025-05-23 19:50:36 UTC
//! Author: @isdood

const std = @import("std");
const Config = @import("../theme/config.zig").Config;
const Color = @import("../theme/colors.zig").Color;
const Branding = @import("../theme/branding.zig").Branding;

/// Quantum sparkle effect generator
pub const SparkleEffect = struct {
    const Self = @This();

    // Core configuration
    config: *const Config,
    intensity: Config.Intensity,
    frame_index: usize,

    // Sparkle characters in order of intensity
    pub const sparkles = [_][]const u8{
        "⋆", "✧", "✦", "✴", "✳", "✯", "★",
    };

    // Sparkle animations for different intensities
    pub const animations = struct {
        pub const subtle = [_][]const u8{"⋆", "･", "｡"};
        pub const moderate = [_][]const u8{"✧", "✦", "✴", "✳"};
        pub const intense = [_][]const u8{"★", "✯", "✨", "⭒"};
        pub const quantum = [_][]const u8{"💫", "✨", "⭐", "💫"};
    };

    pub fn init(config: *const Config) Self {
        return .{
            .config = config,
            .intensity = config.animation.intensity,
            .frame_index = 0,
        };
    }

    /// Generate a sparkle effect based on current settings
    pub fn generate(self: *Self) []const u8 {
        const intensity_level = self.intensity.toFloat();
        const sparkle_index = @intFromFloat(
            usize,
            @intToFloat(f32, sparkles.len - 1) * intensity_level
        );
        return sparkles[sparkle_index];
    }

    /// Update animation frame
    pub fn nextFrame(self: *Self) void {
        if (self.config.animation.enabled) {
            self.frame_index +%= 1;
        }
    }

    /// Get current animation frame based on intensity
    pub fn getCurrentFrame(self: Self) []const u8 {
        const frames = switch (self.intensity) {
            .none => &[_][]const u8{""},
            .subtle => &animations.subtle,
            .moderate => &animations.moderate,
            .intense => &animations.intense,
            .quantum => &animations.quantum,
        };
        return frames[self.frame_index % frames.len];
    }

    /// Apply sparkle effect to text
    pub fn apply(self: *Self, text: []const u8) ![]const u8 {
        if (!self.config.animation.enabled) {
            return text;
        }

        const sparkle = self.generate();
        return try std.fmt.allocPrint(
            std.heap.page_allocator,
            "{s} {s} {s}",
            .{ sparkle, text, sparkle }
        );
    }

    /// Generate a quantum shimmer effect
    pub fn quantumShimmer(self: *Self) ![]const u8 {
        if (!self.config.branding.quantum_shimmer) {
            return "";
        }

        const shimmer = Branding.Animation.shimmer_frames;
        const frame = shimmer[self.frame_index % shimmer.len];
        return try std.fmt.allocPrint(
            std.heap.page_allocator,
            "{s}",
            .{frame}
        );
    }
};

test "sparkle generation" {
    const testing = std.testing;
    const allocator = std.testing.allocator;

    // Test configuration
    var config = Config.init();
    var effect = SparkleEffect.init(&config);

    // Test basic sparkle generation
    const sparkle = effect.generate();
    try testing.expect(sparkle.len > 0);

    // Test text effect application
    const text = "Test";
    const sparkled_text = try effect.apply(text);
    defer allocator.free(sparkled_text);
    try testing.expect(sparkled_text.len > text.len);

    // Test quantum shimmer
    const shimmer = try effect.quantumShimmer();
    defer allocator.free(shimmer);
    try testing.expect(config.branding.quantum_shimmer == (shimmer.len > 0));
}
