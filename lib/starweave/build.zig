//! STARWEAVE Quantum Theme System
//! Created: 2025-05-23 19:31:20 UTC
//! Author: @isdood

const std = @import("std");

pub fn build(b: *std.Build) void {
    // ✧ Standard configuration
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // ✧ STARWEAVE library
    const lib = b.addStaticLibrary(.{
        .name = "starweave",
        .root_source_file = .{ .path = "src/init.zig" },
        .target = target,
        .optimize = optimize,
    });

    // ✧ Install artifacts
    b.installArtifact(lib);

    // ✧ Test configuration
    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/init.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_main_tests = b.addRunArtifact(main_tests);

    // ✧ Test step
    const test_step = b.step("test", "Run STARWEAVE quantum tests");
    test_step.dependOn(&run_main_tests.step);
}
