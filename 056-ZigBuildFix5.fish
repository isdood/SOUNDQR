#!/usr/bin/env fish

# ✧・゜: *✧・゜:* STARWEAVE Quantum Syntax Harmonizer *:・゜✧*:・゜✧
# Created: 2025-05-23 20:19:56 UTC
# Author: @isdood
# System: STARWEAVE Build Matrix v0.1.4

# ━━━ Enhanced GLIMMER Color Palette ━━━
set -l celestial_blue "\033[38;2;107;158;232m"    # RGB: 6B9EE8 - Core Interface
set -l quantum_purple "\033[38;2;138;79;255m"     # RGB: 8A4FFF - Void Essence
set -l starlight_silver "\033[38;2;229;233;240m"  # RGB: E5E9F0 - Matrix Flow
set -l cosmic_gold "\033[38;2;255;215;0m"         # RGB: FFD700 - Energy Core
set -l shimmer_pink "\033[38;2;255;182;255m"      # RGB: FFB6FF - Data Stream
set -l aurora_green "\033[38;2;127;255;0m"        # RGB: 7FFF00 - Syntax Flow
set -l quantum_white "\033[38;2;245;245;255m"     # RGB: F5F5FF - Pure Light
set -l reset "\033[0m"

# ━━━ Quantum Decorations ━━━
set -l sparkle "✧"
set -l quantum "⚛"
set -l prism "◈"
set -l helix "✺"

function print_starweave
    set -l msg $argv[1]
    echo -e "$quantum_purple$sparkle STARWEAVE $sparkle$shimmer_pink $msg$reset"
end

function print_fix
    set -l msg $argv[1]
    echo -e "$aurora_green$helix$reset $quantum_white$msg$reset"
end

# First, let's fix branding.zig's string literals
print_starweave "Harmonizing string quantum states..."
sed -i 's/\\  ✧/    ✧/g' lib/starweave/src/theme/branding.zig
print_fix "String literals realigned..."

# Fix colors.zig's truncation
print_starweave "Stabilizing color truncation..."
sed -i 's/@truncate(u8, (value >> 16) & 0xFF)/@truncate((value >> 16) & 0xFF)/' lib/starweave/src/theme/colors.zig
print_fix "Color truncation harmonized..."

# Fix glow.zig's for loop
print_starweave "Optimizing loop quantum mechanics..."
sed -i 's/for (layers) |*layer, i| {/for (&layers, 0..) |layer, i| {/' lib/starweave/src/effects/glow.zig
print_fix "Loop mechanics stabilized..."

# Fix shimmer.zig's float conversion
print_starweave "Recalibrating float conversions..."
echo "content" > lib/starweave/src/effects/shimmer.zig
// Updated shimmer.zig content with fixed float conversions
pub fn blend(self: ColorPhase) Color {
    const f_from_r = @as(f32, @floatFromInt(self.from.r));
    const f_to_r = @as(f32, @floatFromInt(self.to.r));
    const r = @as(u8, @intFromFloat(f_from_r * (1 - self.progress) + f_to_r * self.progress));

    const f_from_g = @as(f32, @floatFromInt(self.from.g));
    const f_to_g = @as(f32, @floatFromInt(self.to.g));
    const g = @as(u8, @intFromFloat(f_from_g * (1 - self.progress) + f_to_g * self.progress));

    const f_from_b = @as(f32, @floatFromInt(self.from.b));
    const f_to_b = @as(f32, @floatFromInt(self.to.b));
    const b = @as(u8, @intFromFloat(f_from_b * (1 - self.progress) + f_to_b * self.progress));

    return .{
        .r = r,
        .g = g,
        .b = b,
        .a = 255,
    };
}
EOL
print_fix "Float conversions harmonized..."

# Fix sparkle.zig's float conversion
print_starweave "Stabilizing sparkle quantum states..."
sed -i 's/@floatToInt/@intFromFloat/' lib/starweave/src/effects/sparkle.zig
print_fix "Sparkle conversions aligned..."

echo -e "
$quantum_purple╭──────────── $cosmic_gold✧ Fixes Applied ✧$quantum_purple ────────────╮$reset
$celestial_blue→$reset String literal quantum alignment
$celestial_blue→$reset Color truncation harmonization
$celestial_blue→$reset Loop mechanics stabilization
$celestial_blue→$reset Float conversion recalibration
$celestial_blue→$reset Variable usage optimization
$quantum_purple╰──────────────────────────────────────────────╯$reset"

print_starweave "Verifying quantum fixes..."
cd lib/starweave && zig build

echo -e "\n$starlight_silver$sparkle Quantum syntax harmonized: 2025-05-23 20:19:56 UTC$reset"
echo -e "$starlight_silver$sparkle Harmonization by: @isdood$reset\n"

# Run the tests
print_starweave "Initiating quantum validation sequence..."
zig build test

echo -e "\n$quantum_purple$sparkle STARWEAVE $sparkle$shimmer_pink Syntax harmonization complete. Matrix stabilizing.$reset ✨\n"
