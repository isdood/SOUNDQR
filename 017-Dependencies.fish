#!/usr/bin/env fish

# STARWEAVE Dependency Installation
# Created: 2025-05-19 00:46:56 UTC
# Author: isdood

# GLIMMER palette initialization
set -l crystal_flow (tput setaf 51)    # Crystal stream cyan
set -l quantum_beam (tput setaf 147)   # Quantum field purple
set -l starweave_pulse (tput setaf 219) # STARWEAVE status pink
set -l system_aura (tput setaf 123)    # System status blue
set -l time_wave (tput setaf 159)      # Time marker lavender
set -l reset (tput sgr0)

function echo_starweave
    echo $starweave_pulse"[✧ STARWEAVE ✧] "$crystal_flow$argv$reset
end

function check_dependency
    set -l dep_name $argv[1]

    switch $dep_name
        case "base-devel"
            # Check if base-devel package group is installed by checking for make
            if not type -q make
                echo $system_aura"✧ Missing dependency group: "$quantum_beam$dep_name$reset
                return 1
            end
            echo $crystal_flow"✧ Found dependency group: "$quantum_beam$dep_name$reset

        case "*"
            # For all other dependencies, check if the command exists
            if not type -q $dep_name
                echo $system_aura"✧ Missing dependency: "$quantum_beam$dep_name$reset
                return 1
            end
            echo $crystal_flow"✧ Found dependency: "$quantum_beam$dep_name$reset
    end
    return 0
end

# Initialize GLIMMER system check
echo_starweave "✨ Initializing system dependency verification..."

# Check if running on Arch Linux
if not test -f /etc/arch-release
    echo $starweave_pulse"✧ Error: This script requires Arch Linux."$reset
    exit 1
end

# Check if running with sudo privileges
if test (id -u) -ne 0
    echo $starweave_pulse"✧ Please run this script with sudo privileges."$reset
    exit 1
end

# Initialize package manager sync
echo_starweave "✨ Synchronizing package databases..."
pacman -Sy

# Check for existing dependencies
set -l missing_deps 0
for dep in git base-devel npm node
    if not check_dependency $dep
        set missing_deps 1
    end
end

if test $missing_deps -eq 1
    echo_starweave "✨ Installing required system dependencies..."

    # Install dependencies
    echo $quantum_beam"✧ Installing development tools and Node.js environment..."$reset
    pacman -S --needed --noconfirm git base-devel nodejs npm

    # Verify installation
    set verify_failed 0
    for dep in git base-devel npm node
        if not check_dependency $dep
            set verify_failed 1
            echo $starweave_pulse"✧ Failed to install: "$system_aura$dep$reset
        end
    end

    if test $verify_failed -eq 1
        echo $starweave_pulse"✧ Error: Some dependencies failed to install."$reset
        exit 1
    end
else
    echo $crystal_flow"✧ All system dependencies are already installed!"$reset
end

# Configure npm for global installations without sudo
echo_starweave "✨ Configuring npm permissions..."
set -l npm_global_dir ~/.npm-global
if not test -d $npm_global_dir
    mkdir -p $npm_global_dir
    npm config set prefix $npm_global_dir

    echo $quantum_beam"✧ Created npm global directory: "$system_aura$npm_global_dir$reset
end

# Add npm global path to fish config if not present
set -l fish_config ~/.config/fish/config.fish
if not test -f $fish_config
    mkdir -p ~/.config/fish
    touch $fish_config
end

if not grep -q "npm-global/bin" $fish_config
    echo '
# NPM global path
if test -d ~/.npm-global/bin
    set -gx PATH ~/.npm-global/bin $PATH
end' >> $fish_config

    echo $quantum_beam"✧ Updated fish configuration with npm global path"$reset
end

# Install required npm packages globally
echo_starweave "✨ Installing required npm packages..."
npm install -g typescript ts-node @types/node

# Create project directory structure if it doesn't exist
echo_starweave "✨ Verifying project structure..."
for dir in src/{core,codec,patterns} tests/{unit,integration} samples/quantum-viz
    if not test -d $dir
        mkdir -p $dir
        echo $crystal_flow"✧ Created directory: "$quantum_beam$dir$reset
    end
end

# Initialize npm project if package.json doesn't exist
if not test -f package.json
    echo_starweave "✨ Initializing npm project..."
    npm init -y

    # Update package.json with required dependencies
    npm install --save canvas node-flac events
    npm install --save-dev typescript @types/node @types/jest jest ts-jest

    echo $quantum_beam"✧ Initialized new npm project with dependencies"$reset
end

# Create basic tsconfig.json if it doesn't exist
if not test -f tsconfig.json
    echo_starweave "✨ Creating TypeScript configuration..."
    echo '{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "declaration": true,
    "outDir": "./dist",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.test.ts"]
}' > tsconfig.json

    echo $crystal_flow"✧ Created TypeScript configuration file"$reset
end

if test $status -eq 0
    echo $time_wave"✧ Created: 2025-05-19 00:46:56 UTC"$reset
    echo $crystal_flow"✧ Environment setup complete!"$reset
    echo $quantum_beam"✧ You may now proceed with running 018-GlimmerViz.fish"$reset
else
    echo $starweave_pulse"✧ Error: Environment setup failed."$reset
    exit 1
end

# Source the updated fish configuration
source ~/.config/fish/config.fish

echo_starweave "✨ Would you like to:"
echo $crystal_flow"1. Verify the installation with a test build"$reset
echo $quantum_beam"2. Proceed to visualization setup"$reset
echo $starweave_pulse"3. Configure additional development tools"$reset
