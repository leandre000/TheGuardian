# Build Instructions for BabyGuardian iOS App

## Prerequisites

1. **macOS** (required for iOS development)
2. **Xcode 14.0 or later** installed from Mac App Store
3. **XcodeGen** (for generating Xcode project from `project.yml`)
4. **Swift 5.0 or later** (comes with Xcode)

## Installation Steps

### 1. Install XcodeGen (if not already installed)

```bash
# Using Homebrew (recommended)
brew install xcodegen

# Or using Mint
mint install yonaskolb/XcodeGen
```

### 2. Generate Xcode Project

```bash
cd babyG-swift
xcodegen generate
```

This will create `BabyGuardian.xcodeproj` from `project.yml`.

### 3. Install Swift Package Dependencies

Open the project in Xcode:
```bash
open BabyGuardian.xcodeproj
```

Then in Xcode:
- Go to **File > Packages > Resolve Package Versions**
- Or wait for Xcode to automatically resolve packages

The project uses:
- **Charts** (Apple's Swift Charts framework) - for data visualization

### 4. Build and Run

1. Select a simulator (e.g., iPhone 14 Pro) from the device selector
2. Press `Cmd + R` or click the Run button
3. The app will build and launch in the simulator

## Alternative: Manual Xcode Project Creation

If XcodeGen is not available, you can manually create the project:

1. Open Xcode
2. Create a new iOS App project
3. Configure:
   - Product Name: `BabyGuardian`
   - Bundle Identifier: `com.babyguardian.app`
   - Language: Swift
   - UI Framework: SwiftUI
   - Minimum iOS Version: 14.0
4. Add all source files from:
   - `App/`
   - `Models/`
   - `Services/`
   - `Views/`
   - `DesignSystem/`
   - `Resources/`
5. Add Swift Package dependency:
   - File > Add Packages
   - URL: `https://github.com/apple/swift-charts`
   - Version: 1.0.0 or later

## Troubleshooting

### XcodeGen not found
- Install via Homebrew: `brew install xcodegen`
- Or download from: https://github.com/yonaskolb/XcodeGen/releases

### Package resolution fails
- Check internet connection
- In Xcode: File > Packages > Reset Package Caches
- Then: File > Packages > Resolve Package Versions

### Build errors
- Clean build folder: `Cmd + Shift + K`
- Delete derived data: `~/Library/Developer/Xcode/DerivedData`
- Rebuild: `Cmd + B`

## Project Structure

```
babyG-swift/
├── App/                    # App entry point
├── Models/                 # Data models
├── Services/               # Business logic services
├── Views/                  # SwiftUI views
├── DesignSystem/           # Theme and UI components
├── Resources/              # Assets and Info.plist
├── project.yml             # XcodeGen configuration
└── README.md
```

