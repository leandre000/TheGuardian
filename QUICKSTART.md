# Quick Start Guide - BabyGuardian iOS App

## Prerequisites

1. **macOS** with Xcode installed (14.0 or later)
2. **XcodeGen** for project generation:
   ```bash
   brew install xcodegen
   ```
3. **iOS Simulator** or physical iOS device (iOS 14.0+)

## Setup Instructions

### Step 1: Generate Xcode Project

Navigate to the project directory and generate the Xcode project:

```bash
cd "C:\Users\Shema Leandre\Desktop\babyG-swift"
xcodegen generate
```

This will create `BabyGuardian.xcodeproj` file.

### Step 2: Open in Xcode

```bash
open BabyGuardian.xcodeproj
```

Or double-click the `.xcodeproj` file in Finder.

### Step 3: Configure Signing

1. In Xcode, select the **BabyGuardian** target
2. Go to **Signing & Capabilities** tab
3. Select your **Team** (or enable "Automatically manage signing")
4. Xcode will generate a provisioning profile

### Step 4: Select Simulator or Device

1. In Xcode toolbar, click the device selector
2. Choose an iOS Simulator (e.g., iPhone 14, iPhone 15 Pro)
3. Or connect a physical device and select it

### Step 5: Build and Run

1. Press **⌘ + R** (or click the Play button)
2. Wait for the app to build and launch in the simulator

## Running in Simulator

The app will launch in the iOS Simulator. You can:

- **View Dashboard**: See real-time health metrics
- **Monitor Health**: View detailed health charts and data
- **Check Alerts**: Review safety alerts and notifications
- **Watch Camera**: Access live camera feed (simulated)
- **Configure Settings**: Adjust app preferences

## Features to Test

### 1. Health Monitoring
- Real-time heart rate, temperature, and oxygen saturation
- Sleep quality tracking
- Historical data visualization

### 2. Safety Alerts
- Bed edge detection alerts
- Dangerous gas detection
- Smoke detection
- Critical alerts trigger sound notifications

### 3. Cry Detection
- Automatic cry detection
- Comfort system activation
- Visual indicators on camera view

### 4. Alert Classification
- **Critical**: Fall, dangerous gas, smoke, bed edge (sound alert)
- **High**: Heart rate, oxygen, temperature (sound alert)
- **Medium**: Cry detection (visual only)
- **Low**: General notifications

## Troubleshooting

### Issue: "No such module 'Charts'"
**Solution**: The Charts framework is optional. If you get this error:
1. Remove Charts dependency from `project.yml` (the `packages:` and `dependencies:` sections)
2. Regenerate the project: `xcodegen generate`
3. The app will use the fallback `SimpleLineGraph` for iOS < 16

### Issue: Build Errors
**Solution**: 
1. Clean build folder: **⌘ + Shift + K**
2. Clean derived data: **⌘ + Option + Shift + K**
3. Rebuild: **⌘ + B**

### Issue: Simulator Not Launching
**Solution**:
1. Check Xcode > Preferences > Components for installed simulators
2. Download iOS Simulator if missing
3. Try a different simulator model

## Project Structure

```
babyG-swift/
├── App/                    # Main app entry
├── Models/                 # Data models
├── Services/               # Business logic services
├── Views/                  # SwiftUI views
├── DesignSystem/           # Theming and components
├── Resources/              # Assets and configuration
└── project.yml             # XcodeGen configuration
```

## Next Steps

1. **Connect Real Devices**: Replace simulated data with actual IoT sensor data
2. **Add Camera Integration**: Implement real video streaming
3. **Implement Cloud Backend**: Add data sync and storage
4. **Add Localization**: Implement multilingual support
5. **Add AI Features**: Implement predictive insights

## Development Notes

- The app uses **simulated data** for demonstration
- Health metrics update every 2 seconds
- Sensor data updates every 1 second
- Alerts are generated based on threshold violations
- Sound alerts play for critical/high priority alerts

---

**Happy Coding! 🚀**

