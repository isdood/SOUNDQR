//! STARWEAVE Branding System
//! Created: 2025-05-23 19:45:07 UTC
//! Author: @isdood

const std = @import("std");
const Config = @import("config.zig").Config;
const Color = @import("colors.zig").Color;

/// STARWEAVE core branding elements
pub const Branding = struct {
    /// Core identity components
    pub const Identity = struct {
        pub const name = "STARWEAVE";
        pub const version = "0.1.0";
        pub const tagline = "Harmonizing Digital Dreams";

        pub const logo_small =
            \    ✧ STARWEAVE ✧
            \  Digital Harmony
        ;

        pub const logo_medium =
            \  ⋆｡°✧⭒✦ STARWEAVE ✦⭒✧°｡⋆
            \  Quantum Theme Harmonizer
            \  Weaving Digital Dreams
        ;

        pub const logo_large =
            \  ╭──────────────────────────╮
            \  │  ⋆｡°✧⭒✦ STARWEAVE ✦⭒✧°｡⋆  │
            \  │  Quantum Theme System    │
            \  │  Harmonizing Realities   │
            \  ╰──────────────────────────╯
        ;
    };

    /// Decorative elements
    pub const Decorative = struct {
        pub const sparkle = "✧";
        pub const star = "★";
        pub const crystal = "💎";
        pub const cosmos = "✴";
        pub const prism = "◈";

        pub const separators = struct {
            pub const simple = "━━━";
            pub const ornate = "─────✧─────";
            pub const quantum = "⋆｡°✧⭒✦⭒✧°｡⋆";
        };
    };

    /// Message formatting
    pub const MessageFormat = struct {
        const Self = @This();

        config: *const Config,
        intensity: Config.Intensity,

        pub fn init(config: *const Config) Self {
            return .{
                .config = config,
                .intensity = .moderate,
            };
        }

        /// Format a status message with STARWEAVE branding
        pub fn status(self: Self, message: []const u8) ![]const u8 {
            if (self.config.branding.show_logo) {
                return try std.fmt.allocPrint(
                    std.heap.page_allocator,
                    "{s} {s} {s} {s}",
                    .{
                        Decorative.sparkle,
                        Identity.name,
                        Decorative.sparkle,
                        message,
                    },
                );
            } else {
                return try std.fmt.allocPrint(
                    std.heap.page_allocator,
                    "{s} {s}",
                    .{ Decorative.sparkle, message },
                );
            }
        }

        /// Format an error message with gentle branding
        pub fn error(self: Self, message: []const u8) ![]const u8 {
            return try std.fmt.allocPrint(
                std.heap.page_allocator,
                "{s} Error: {s}",
                .{ Decorative.crystal, message },
            );
        }
    };

    /// Animation sequences
    pub const Animation = struct {
        pub const sparkle_frames = [_][]const u8{
            "✧", "✦", "✴", "✳",
        };

        pub const shimmer_frames = [_][]const u8{
            "⋆｡°✧", "｡°✧⭒", "°✧⭒✦", "✧⭒✦⋆",
        };
    };
};

test "message formatting" {
    const testing = std.testing;
    const allocator = std.testing.allocator;

    // Test configuration
    var config = Config.init();
    const formatter = Branding.MessageFormat.init(&config);

    // Test status message
    const status_msg = try formatter.status("Test Status");
    defer allocator.free(status_msg);
    try testing.expect(std.mem.indexOf(u8, status_msg, "STARWEAVE") != null);

    // Test error message
    const error_msg = try formatter.error("Test Error");
    defer allocator.free(error_msg);
    try testing.expect(std.mem.indexOf(u8, error_msg, "Error:") != null);
}
