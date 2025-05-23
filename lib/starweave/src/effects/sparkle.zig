pub fn calculateSparkleIndex(value: f32) u32 {
    const sparkle_index = @floatToInt(u32, value * 1000.0);
    return sparkle_index;
}
