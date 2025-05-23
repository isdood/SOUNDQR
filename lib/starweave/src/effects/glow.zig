
pub fn applyGlow(layers: []Layer) void {
    // Updated for loop syntax for Zig 0.11.0
    for (layers, 0..) |*layer, i| {
        layer.glow_factor = @floatCast(f32, i) / @floatCast(f32, layers.len);
    }
}

