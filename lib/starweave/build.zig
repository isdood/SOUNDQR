const std = @import("std");

// ✧ STARWEAVE Build Quantum Harmonizer ✧
pub fn build(b: *std.Build) void {
    // Target quantum configuration
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // ✨ STARWEAVE Library Harmonization
    const lib = b.addStaticLibrary(.{
        .name = "starweave",
        .root_source_file = std.Build.LazyPath.relative("src/init.zig"),
        .target = target,
        .optimize = optimize,
    });

    // 🌟 Install the harmonized library
    b.installArtifact(lib);

    // 🌠 Quantum Test Configuration
    const main_tests = b.addTest(.{
        .root_source_file = std.Build.LazyPath.relative("src/init.zig"),
        .target = target,
        .optimize = optimize,
    });

    const run_main_tests = b.addRunArtifact(main_tests);

    // ✨ Test Quantum Step
    const test_step = b.step("test", "Run STARWEAVE quantum harmonization tests");
    test_step.dependOn(&run_main_tests.step);

    // 🌠 Documentation Quantum Generation
    const lib_docs = b.addInstallDirectory(.{
        .source_dir = lib.getEmittedDocs(),
        .install_dir = .prefix,
        .install_subdir = "doc",
    });

    const docs_step = b.step("docs", "Generate STARWEAVE quantum documentation");
    docs_step.dependOn(&lib_docs.step);
}
