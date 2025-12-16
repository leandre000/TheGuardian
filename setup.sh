#!/bin/bash

# BabyGuardian iOS App Setup Script
# This script sets up the project for building in Xcode

echo "🚀 Setting up BabyGuardian iOS App..."

# Check if XcodeGen is installed
if ! command -v xcodegen &> /dev/null; then
    echo "❌ XcodeGen is not installed"
    echo "📦 Installing XcodeGen via Homebrew..."
    
    if command -v brew &> /dev/null; then
        brew install xcodegen
    else
        echo "❌ Homebrew is not installed. Please install Homebrew first:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
fi

echo "✅ XcodeGen is installed"

# Generate Xcode project
echo "📝 Generating Xcode project from project.yml..."
xcodegen generate

if [ $? -eq 0 ]; then
    echo "✅ Xcode project generated successfully!"
    echo "📂 Project file: BabyGuardian.xcodeproj"
else
    echo "❌ Failed to generate Xcode project"
    exit 1
fi

# Open in Xcode
echo "🔧 Opening project in Xcode..."
open BabyGuardian.xcodeproj

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Wait for Xcode to resolve Swift Package dependencies"
echo "2. Select an iPhone simulator (e.g., iPhone 14 Pro)"
echo "3. Press Cmd + R to build and run"
echo ""

