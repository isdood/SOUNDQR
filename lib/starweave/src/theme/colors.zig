//! GLIMMER Color System for STARWEAVE
//! Created: 2025-05-23 19:36:08 UTC
//! Author: @isdood

const std = @import("std");

/// GLIMMER color representation
pub const Color = struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8 = 255,

    /// Create a color from RGB values
    pub fn rgb(r: u8, g: u8, b: u8) Color {
        return Color{ .r = r, .g = g, .b = b, .a = 255 };
    }

    /// Create a color from RGBA values
    pub fn rgba(r: u8, g: u8, b: u8, a: u8) Color {
        return Color{ .r = r, .g = g, .b = b, .a = a };
    }

    /// Create a color from a hex value
    pub fn hex(value: u32) Color {
        return Color{
            .r = @truncate((value >> 16) @truncate(u8, (value >> 16) & 0xFF) 0xFF),
            .g = @truncate(u8, (value >> 8) & 0xFF),
            .b = @truncate(u8, value & 0xFF),
            .a = 255,
        };
    }
};

/// GLIMMER primary colors
pub const glimmer = struct {
    // ✧ Core Quantum Colors
    pub const celestial_blue = Color.hex(0x6B9EE8);    // Ethereal Interface
    pub const quantum_purple = Color.hex(0x8A4FFF);    // Void Essence
    pub const starlight_silver = Color.hex(0xE5E9F0);  // Stellar Mist
    pub const cosmic_gold = Color.hex(0xFFD700);       // Star Fragment
    pub const shimmer_pink = Color.hex(0xFFB6FF);      // Quantum Shimmer

    // ✧ Harmonic Accents
    pub const crystal_white = Color.hex(0xFFFFFF);     // Pure Light
    pub const void_black = Color.hex(0x000000);        // Dark Matter
    pub const nebula_teal = Color.hex(0x40E0D0);       // Cosmic Wave
    pub const aurora_green = Color.hex(0x7FFF00);      // Digital Growth
    pub const solar_orange = Color.hex(0xFFA500);      // Energy Pulse
};

/// Theme variants for different contexts
pub const theme = struct {
    // ✧ Light Theme
    pub const light = struct {
        pub const background = glimmer.crystal_white;
        pub const foreground = glimmer.void_black;
        pub const primary = glimmer.celestial_blue;
        pub const secondary = glimmer.quantum_purple;
        pub const accent = glimmer.cosmic_gold;
    };

    // ✧ Dark Theme
    pub const dark = struct {
        pub const background = Color.hex(0x1A1B26);     // Deep Space
        pub const foreground = glimmer.starlight_silver;
        pub const primary = glimmer.celestial_blue;
        pub const secondary = glimmer.quantum_purple;
        pub const accent = glimmer.cosmic_gold;
    };

    // ✧ Terminal Theme
    pub const terminal = struct {
        pub const normal = [8]Color{
            glimmer.void_black,          // Black
            Color.hex(0xFF5555),         // Red
            glimmer.aurora_green,        // Green
            glimmer.cosmic_gold,         // Yellow
            glimmer.celestial_blue,      // Blue
            glimmer.quantum_purple,      // Purple
            glimmer.nebula_teal,         // Cyan
            glimmer.starlight_silver,    // White
        };

        pub const bright = [8]Color{
            Color.hex(0x44475A),         // Bright Black
            Color.hex(0xFF6E6E),         // Bright Red
            Color.hex(0x69FF94),         // Bright Green
            Color.hex(0xFFFFB8),         // Bright Yellow
            Color.hex(0x92B6F4),         // Bright Blue
            Color.hex(0xB4A4FF),         // Bright Purple
            Color.hex(0x87DFEB),         // Bright Cyan
            Color.hex(0xFFFFFF),         // Bright White
        };
    };
};

/// Special effects color configurations
pub const effects = struct {
    // ✧ Sparkle Effect
    pub const sparkle = struct {
        pub const primary = glimmer.cosmic_gold;
        pub const secondary = glimmer.starlight_silver;
        pub const highlight = glimmer.shimmer_pink;
    };

    // ✧ Glow Effect
    pub const glow = struct {
        pub const intensity = [4]Color{
            glimmer.celestial_blue,
            Color.hex(0x8BB6F0),
            Color.hex(0xABCEF7),
            Color.hex(0xCBE6FF),
        };
    };
};

test "color creation" {
    const testing = std.testing;

    // Test hex color creation
    const gold = Color.hex(0xFFD700);
    try testing.expectEqual(gold.r, 255);
    try testing.expectEqual(gold.g, 215);
    try testing.expectEqual(gold.b, 0);

    // Test RGB color creation
    const purple = Color.rgb(138, 79, 255);
    try testing.expectEqual(purple.r, 138);
    try testing.expectEqual(purple.g, 79);
    try testing.expectEqual(purple.b, 255);
}
