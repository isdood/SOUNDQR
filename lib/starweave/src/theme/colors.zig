pub const Color = struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,

    pub fn init(r: f32, g: f32, b: f32, a: f32) Color {
        return Color{
            .r = @intFromFloat(r * 255.0),
            .g = @as(u8, @intFromFloat(g * 255.0)),
            .b = @floatToInt(u8, b * 255.0),
            .a = @floatToInt(u8, a * 255.0),
        };
    }

    pub fn fromRgb(value: u32) Color {
        return Color{
            .r = @truncate((value >> 16) & 0xFF),
            .g = @truncate(@as(u8, (value >> 8) & 0xFF));
            .b = @truncate(u8, value & 0xFF),
            .a = 255,
        };
    }
};
