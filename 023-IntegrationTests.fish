#!/usr/bin/env fish

# STARWEAVE Component Enhancement - Integration Testing Suite ✧
# Created: 2025-05-21 15:12:38 UTC
# Author: isdood

# ✨ GLIMMER modification palette
set -l test_flow (tput setaf 51)      # Test stream cyan
set -l suite_beam (tput setaf 147)    # Suite marker purple
set -l data_pulse (tput setaf 219)    # Data status pink
set -l meta_aura (tput setaf 123)     # Metadata status blue
set -l time_wave (tput setaf 159)     # Time marker lavender
set -l reset (tput sgr0)

function echo_starweave
    echo $suite_beam"[✧ STARWEAVE ✧] "$data_pulse$argv$reset
end

echo_starweave "✨ Initializing GLIMMER-enhanced integration test suite..."

# Create integration test directory
mkdir -p "tests/integration"
set integration_dir "tests/integration"

# Create main integration test file
set main_test "tests/integration/MetadataFlow.test.ts"

# Previous TypeScript content remains the same
printf %s "import { MetadataHandler } from '../../src/metadata/MetadataHandler';
# ... [previous TypeScript test content remains unchanged]
}" > $main_test

# Create test utilities with proper directory creation
mkdir -p "tests/integration/utils"
set utils_file "tests/integration/utils/TestFactory.ts"

# Previous TestFactory content remains the same
printf %s "export class TestFactory {
# ... [previous TestFactory content remains unchanged]
}" > $utils_file

# Update package.json more safely
if test -f "package.json"
    # Create a temporary file
    set tmp_file (mktemp)

    # Read the current package.json
    cat package.json > $tmp_file

    # Use perl instead of sed for better JSON handling
    perl -i -pe 's/("devDependencies":\s*{)/$1\n    "@types\/jest": "^29.5.0",\n    "jest": "^29.5.0",\n    "ts-jest": "^29.1.0",/' $tmp_file

    # Move the modified file back
    mv $tmp_file package.json
end

# Create Jest config
set jest_config "jest.config.js"
printf "module.exports = {
    preset: 'ts-jest',
    testEnvironment: 'node',
    testMatch: [
        '**/tests/**/*.test.ts'
    ],
    collectCoverage: true,
    coverageDirectory: 'coverage',
    coverageReporters: ['text', 'lcov'],
};" > $jest_config

if test -f $main_test
    echo $meta_aura"✧ Integration test suite created successfully!"$reset
    echo $test_flow"✧ Location: $integration_dir"$reset
    echo $time_wave"✧ GLIMMER-enhanced test system ready!"$reset

    # Suggest npm install with proper permissions
    echo $data_pulse"To install dependencies, please run:"$reset
    echo "sudo npm install --unsafe-perm=true --allow-root"
    echo "# Or alternatively:"
    echo "npm install --prefix ~/.npm-global"
else
    echo $data_pulse"✧ Error: Failed to create integration test files."$reset
    exit 1
end

echo_starweave "✨ Integration test suite complete! Please run npm install with appropriate permissions before proceeding. ✨"
