//! STARWEAVE Build System
//! Created: 2025-05-23 20:10:34 UTC
//! Author: @isdood

const std = @import("std");

pub fn build(b: *std.Build) void {
    // ✧ Standard configuration
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // ✧ STARWEAVE library
    const lib = b.addStaticLibrary(.{
        .name = "starweave",
        .root_source_file = b.addPath("src/init.zig"),
        .target = target,
        .optimize = optimize,
    });

    // ✧ Install artifacts
    b.installArtifact(lib);

    // ✧ Create main test step
    const main_tests = b.addTest(.{
        .root_source_file = b.addPath("src/init.zig"),
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
}
