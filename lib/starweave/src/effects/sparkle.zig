pub fn calculateSparkleIndex(value: f32) u32 {
    const sparkle_index = @as(u32, @intFromFloat(value * 1000.0));
    return sparkle_index;
}
