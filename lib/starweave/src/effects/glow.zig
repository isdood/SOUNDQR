pub const Layer = struct {
    glow_factor: f32 = 0.0,
};

pub fn applyGlow(layers: []Layer) void {
    for (layers, 0..) |*layer, i| {
        layer.glow_factor = @as(f32, @floatFromInt(i)) / @as(f32, @floatFromInt(layers.len));
    }
}
