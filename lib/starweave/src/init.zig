const std = @import("std");

pub const effects = struct {
    pub const shimmer = @import("effects/shimmer.zig");
    pub const glow = @import("effects/glow.zig");
    pub const sparkle = @import("effects/sparkle.zig");
};

pub const theme = struct {
    pub const colors = @import("theme/colors.zig");
    pub const branding = @import("theme/branding.zig");
};

test {
    std.testing.refAllDecls(@This());
}
