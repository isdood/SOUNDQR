//! STARWEAVE Configuration System
//! Created: 2025-05-23 19:41:09 UTC
//! Author: @isdood

const std = @import("std");
const Color = @import("colors.zig").Color;

/// STARWEAVE core configuration
pub const Config = struct {
    /// Theme variant selection
    pub const ThemeVariant = enum {
        light,
        dark,
        system,
        quantum,
    };

    /// Effect intensity levels
    pub const Intensity = enum {
        none,
        subtle,
        moderate,
        intense,
        quantum,

        pub fn toFloat(self: Intensity) f32 {
            return switch (self) {
                .none => 0.0,
                .subtle => 0.25,
                .moderate => 0.5,
                .intense => 0.75,
                .quantum => 1.0,
            };
        }
    };

    /// Animation configuration
    pub const Animation = struct {
        enabled: bool = true,
        speed: f32 = 1.0,
        intensity: Intensity = .moderate,
        quantum_effects: bool = true,
    };

    /// STARWEAVE branding configuration
    pub const Branding = struct {
        show_logo: bool = true,
        animate_logo: bool = true,
        sparkle_effect: bool = true,
        quantum_shimmer: bool = true,
    };

    /// Terminal support configuration
    pub const Terminal = struct {
        unicode_support: bool = true,
        color_support: bool = true,
        animation_support: bool = true,
        effects_support: bool = true,
    };

    // Core configuration fields
    theme: ThemeVariant = .quantum,
    animation: Animation = .{},
    branding: Branding = .{},
    terminal: Terminal = .{},

    /// Initialize with default quantum settings
    pub fn init() Config {
        return .{};
    }

    /// Initialize with system-aware settings
    pub fn initSystem() !Config {
        var config = Config{};
        config.terminal.unicode_support = try detectUnicodeSupport();
        config.terminal.color_support = try detectColorSupport();
        config.terminal.animation_support = try detectAnimationSupport();
        return config;
    }

    /// Create a minimal configuration for limited environments
    pub fn minimal() Config {
        return .{
            .theme = .light,
            .animation = .{ .enabled = false },
            .branding = .{
                .show_logo = true,
                .animate_logo = false,
                .sparkle_effect = false,
                .quantum_shimmer = false,
            },
            .terminal = .{
                .unicode_support = false,
                .color_support = true,
                .animation_support = false,
                .effects_support = false,
            },
        };
    }
};

/// Terminal capability detection
fn detectUnicodeSupport() !bool {
    // Implementation will check LANG and LC_ALL environment variables
    return true; // Placeholder
}

fn detectColorSupport() !bool {
    // Implementation will check COLORTERM and TERM environment variables
    return true; // Placeholder
}

fn detectAnimationSupport() !bool {
    // Implementation will check terminal type and capabilities
    return true; // Placeholder
}

test "config initialization" {
    const testing = std.testing;

    // Test default initialization
    const config = Config.init();
    try testing.expectEqual(config.theme, .quantum);
    try testing.expect(config.animation.enabled);
    try testing.expect(config.branding.sparkle_effect);

    // Test minimal configuration
    const minimal = Config.minimal();
    try testing.expectEqual(minimal.theme, .light);
    try testing.expect(!minimal.animation.enabled);
    try testing.expect(!minimal.branding.quantum_shimmer);
}

test "intensity conversion" {
    const testing = std.testing;

    try testing.expectEqual(Config.Intensity.none.toFloat(), 0.0);
    try testing.expectEqual(Config.Intensity.quantum.toFloat(), 1.0);
}
