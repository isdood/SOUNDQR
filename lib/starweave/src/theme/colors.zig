
pub fn fromRgb(value: u32) Color {
    return Color{
        .r = @truncate(u8, (value >> 16) & 0xFF),
        .g = @truncate(u8, (value >> 8) & 0xFF),
        .b = @truncate(u8, value & 0xFF),
        .a = 255,
    };
}

