//! STARWEAVE Core System Tests
//! Created: 2025-05-23 20:01:02 UTC
//! Author: @isdood

const std = @import("std");
const testing = std.testing;
const starweave = @import("../src/init.zig");

test "core initialization" {
    // Test default initialization
    const core = try starweave.StarweaveCore.init();
    try testing.expect(core.config.animation.enabled);
    try testing.expect(core.config.branding.show_logo);

    // Test minimal initialization
    const minimal = starweave.StarweaveCore.minimal();
    try testing.expect(!minimal.config.animation.enabled);
}

test "effect application" {
    var core = try starweave.StarweaveCore.init();
    const text = "STARWEAVE";

    // Test effect application
    const enhanced = try core.applyEffects(text);
    defer std.heap.page_allocator.free(enhanced);
    try testing.expect(enhanced.len > text.len);
}

test "animation update" {
    var core = try starweave.StarweaveCore.init();
    const delta: f32 = 0.016;

    // Test animation update
    core.update(delta);
    try testing.expect(true); // Update completed without errors
}

test "version information" {
    try testing.expectEqual(starweave.version.major, 0);
    try testing.expectEqual(starweave.version.minor, 1);
    try testing.expectEqual(starweave.version.patch, 0);
    try testing.expectEqualStrings(starweave.version.string, "0.1.0");
}
