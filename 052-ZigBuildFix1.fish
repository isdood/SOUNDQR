#!/usr/bin/env fish

# ✧・゜: *✧・゜:* STARWEAVE Build Harmonizer *:・゜✧*:・゜✧
# Created: 2025-05-23 20:05:37 UTC
# Author: @isdood
# System: STARWEAVE Build Matrix v0.1.0

# ━━━ GLIMMER Color Palette (Build Matrix) ━━━
set -l celestial_blue "\033[38;2;107;158;232m"    # RGB: 6B9EE8 - Build Interface
set -l quantum_purple "\033[38;2;138;79;255m"     # RGB: 8A4FFF - Build Core
set -l starlight_silver "\033[38;2;229;233;240m"  # RGB: E5E9F0 - Build Flow
set -l cosmic_gold "\033[38;2;255;215;0m"         # RGB: FFD700 - Build Energy
set -l shimmer_pink "\033[38;2;255;182;255m"      # RGB: FFB6FF - Build Stream
set -l matrix_green "\033[38;2;0;255;127m"        # RGB: 00FF7F - Build Status
set -l reset "\033[0m"

# ━━━ Build Decorations ━━━
set -l sparkle "✧"
set -l gear "⚙"
set -l crystal "💎"

function print_starweave
    set -l msg $argv[1]
    echo -e "$quantum_purple$sparkle STARWEAVE $sparkle$shimmer_pink $msg$reset"
end

function print_build
    set -l msg $argv[1]
    echo -e "$matrix_green$gear$reset $starlight_silver$msg$reset"
end

# ━━━ STARWEAVE Build Banner ━━━
echo -e "
$quantum_purple╭──────────────────────────────────────────────╮$reset
$quantum_purple│$cosmic_gold    ⋆｡°✧⭒✦ BUILD MATRIX ✦⭒✧°｡⋆     $quantum_purple│$reset
$quantum_purple│$shimmer_pink    STARWEAVE Build System Harmonizer    $quantum_purple│$reset
$quantum_purple│$starlight_silver    Stabilizing Quantum Compilation    $quantum_purple│$reset
$quantum_purple╰──────────────────────────────────────────────╯$reset
"

set build_path "lib/starweave/build.zig"

print_starweave "Initializing build matrix harmonization..."

# Update build.zig with Zig 0.13.0 compatible syntax
echo '//! STARWEAVE Build System
//! Created: 2025-05-23 20:05:37 UTC
//! Author: @isdood

const std = @import("std");

pub fn build(b: *std.Build) void {
    // ✧ Standard configuration
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // ✧ STARWEAVE library
    const lib = b.addStaticLibrary(.{
        .name = "starweave",
        .root_source_file = .{ .root = "src/init.zig" },
        .target = target,
        .optimize = optimize,
    });

    // ✧ Install artifacts
    b.installArtifact(lib);

    // ✧ Create main test step
    const main_tests = b.addTest(.{
        .root_source_file = .{ .root = "src/init.zig" },
        .target = target,
        .optimize = optimize,
    });

    // ✧ Create test runner
    const run_main_tests = b.addRunArtifact(main_tests);

    // ✧ Test step
    const test_step = b.step("test", "Run STARWEAVE quantum tests");
    test_step.dependOn(&run_main_tests.step);

    // ✧ Add documentation
    const docs = b.addInstallDirectory(.{
        .source_dir = lib.getEmittedDocs(),
        .install_dir = .prefix,
        .install_subdir = "docs",
    });

    // ✧ Documentation step
    const docs_step = b.step("docs", "Build STARWEAVE documentation");
    docs_step.dependOn(&docs.step);
}' > $build_path

print_build "Build matrix updated for Zig 0.13.0..."
print_build "Documentation generation added..."
print_build "Test runner harmonized..."

echo -e "
$quantum_purple╭───────────── $cosmic_gold✧ Build Ready ✧$quantum_purple ──────────────╮$reset
$celestial_blue→$reset Updated root_source_file syntax
$celestial_blue→$reset Enhanced build configuration
$celestial_blue→$reset Added documentation system
$celestial_blue→$reset Optimized test runner
$celestial_blue→$reset Matrix harmonization complete
$quantum_purple╰──────────────────────────────────────────────╯$reset"

# Verify the build
print_starweave "Verifying quantum build matrix..."
cd lib/starweave && zig build

echo -e "\n$starlight_silver$sparkle Build matrix harmonized: 2025-05-23 20:05:37 UTC$reset"
echo -e "$starlight_silver$sparkle Quantum compilation achieved by: @isdood$reset\n"

# Run the tests
print_starweave "Initiating quantum validation sequence..."
echo -e "$celestial_blue→$reset Running core system tests...\n"

zig build test

echo -e "\n$quantum_purple$sparkle STARWEAVE $sparkle$shimmer_pink Build matrix stabilized. Let your code compile with quantum precision.$reset ✨\n"
