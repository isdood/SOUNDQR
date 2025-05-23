//! STARWEAVE Quantum Core System
//! Created: 2025-05-23 20:17:04 UTC
//! Author: @isdood

const std = @import("std");
pub const Config = @import("theme/config.zig").Config;
pub const Color = @import("theme/colors.zig").Color;
pub const glimmer = @import("theme/colors.zig").glimmer;
pub const Branding = @import("theme/branding.zig").Branding;
pub const SparkleEffect = @import("effects/sparkle.zig").SparkleEffect;
pub const ShimmerEffect = @import("effects/shimmer.zig").ShimmerEffect;
pub const GlowEffect = @import("effects/glow.zig").GlowEffect;

/// STARWEAVE core system
pub const StarweaveCore = struct {
    const Self = @This();

    config: Config,
    sparkle: SparkleEffect,
    shimmer: ShimmerEffect,
    glow: GlowEffect,

    /// Initialize STARWEAVE system
    pub fn init() !Self {
        var config = try Config.initSystem();
        return Self{
            .config = config,
            .sparkle = SparkleEffect.init(&config),
            .shimmer = ShimmerEffect.init(&config),
            .glow = GlowEffect.init(&config),
        };
    }

    /// Initialize with minimal configuration
    pub fn minimal() Self {
        var config = Config.minimal();
        return Self{
            .config = config,
            .sparkle = SparkleEffect.init(&config),
            .shimmer = ShimmerEffect.init(&config),
            .glow = GlowEffect.init(&config),
        };
    }

    /// Apply all quantum effects to text
    pub fn applyEffects(self: *Self, text: []const u8) ![]const u8 {
        // Use const for immutable values
        const sparkled = try self.sparkle.apply(text);
        defer std.heap.page_allocator.free(sparkled);

        const shimmered = try self.shimmer.apply(sparkled);
        defer std.heap.page_allocator.free(shimmered);

        return try self.glow.apply(shimmered);
    }

    /// Update all animation states
    pub fn update(self: *Self, delta: f32) void {
        self.sparkle.update(delta);
        self.shimmer.update(delta);
        self.glow.update(delta);
    }
};

/// STARWEAVE version information
pub const version = struct {
    pub const major = 0;
    pub const minor = 1;
    pub const patch = 0;
    pub const string = "0.1.0";
};
