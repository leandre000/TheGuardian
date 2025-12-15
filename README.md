# BabyGuardian - Smart Baby Monitoring & Health Tracking System

## Overview

BabyGuardian is a comprehensive iOS application designed to provide parents with real-time monitoring of their infant's health, safety, and comfort. The app integrates with wearable health devices, smart sensors, and camera systems to deliver peace of mind for parents.

## Features

### Core Features

1. **Health Monitoring**
   - Real-time vital signs tracking (heart rate, temperature, oxygen saturation)
   - Sleep quality monitoring
   - Historical data visualization
   - Health metrics dashboard

2. **Safety Alerts**
   - Bed edge detection alerts
   - Dangerous gas detection
   - Smoke detection
   - Temperature and environmental alerts
   - Alert classification system (Critical, High, Medium, Low priority)
   - Sound alerts for critical situations

3. **Cry Detection & Comfort System**
   - Automatic cry detection
   - Auto-triggered lullaby/comfort sounds
   - Cry intensity monitoring

4. **Camera Monitoring**
   - Live video streaming
   - Real-time monitoring
   - Snapshot capture
   - Video recording

5. **AI Insights** (Future Enhancement)
   - Sleep cycle predictions
   - Feeding time recommendations
   - Health anomaly detection

6. **Multilingual Support**
   - English, French, Spanish, Swahili, Kinyarwanda

## Project Structure

```
babyG-swift/
├── App/
│   └── BabyGuardianApp.swift          # Main app entry point
├── Models/
│   ├── HealthData.swift                # Health metrics models
│   └── AlertClassification.swift       # Alert classification system
├── Services/
│   ├── HealthMonitoringService.swift   # Health data service
│   ├── SensorService.swift             # IoT sensor service
│   ├── AlertManager.swift              # Alert management
│   └── CryDetectionService.swift       # Cry detection service
├── Views/
│   ├── ContentView.swift               # Main tab view
│   ├── DashboardView.swift             # Dashboard with metrics
│   ├── MonitoringView.swift            # Detailed health monitoring
│   ├── AlertsView.swift                # Alerts management
│   ├── CameraView.swift                # Live camera feed
│   └── SettingsView.swift              # App settings
├── DesignSystem/
│   ├── Theme.swift                      # App theming
│   └── UIComponents.swift              # Reusable components
├── Resources/
│   └── Info.plist                      # App configuration
├── project.yml                          # XcodeGen configuration
└── README.md                            # This file
```

## Requirements

- iOS 14.0+
- Xcode 14.0+
- Swift 5.0+
- macOS 12.0+ (for development)

## Installation

### Prerequisites

1. Install [XcodeGen](https://github.com/yonaskolb/XcodeGen):
   ```bash
   brew install xcodegen
   ```

2. Generate Xcode project:
   ```bash
   xcodegen generate
   ```

3. Open the generated project:
   ```bash
   open BabyGuardian.xcodeproj
   ```

4. Build and run in Xcode Simulator or on a physical device.

## Usage

### Initial Setup

1. Launch the app
2. Connect wearable device via Bluetooth
3. Configure alert thresholds in Settings
4. Enable camera and microphone permissions
5. Start monitoring

### Monitoring Your Baby

- **Dashboard**: View real-time health metrics and safety status
- **Monitoring**: Detailed health charts and historical data
- **Alerts**: Review and acknowledge safety alerts
- **Camera**: Live video feed with cry detection overlay
- **Settings**: Configure app preferences and thresholds

### Alert System

The app classifies alerts by severity:

- **Critical**: Fall detection, dangerous gas, smoke, bed edge
  - Triggers sound alert immediately
  - Requires immediate attention
  
- **High**: Heart rate, oxygen, temperature anomalies
  - Triggers sound alert
  - Requires prompt attention
  
- **Medium**: Cry detection
  - Visual notification only
  
- **Low**: General notifications
  - Visual notification only

## Architecture

The app follows MVVM (Model-View-ViewModel) architecture with SwiftUI:

- **Models**: Data structures and business logic
- **Services**: Data management and business services
- **Views**: SwiftUI views and UI components
- **Environment Objects**: Shared state management

## Data Privacy & Security

- All data is encrypted (AES-256)
- Compliant with GDPR, HIPAA, and COPPA regulations
- Local data storage with optional cloud sync
- Role-based access control

## Future Enhancements

- Smart diaper sensor integration
- Feeding tracker with AI recommendations
- Pediatrician integration and telemedicine
- Smart home system integration (Alexa, Google Home)
- Temperature control system integration
- Advanced AI insights and predictions

## Development

### Running Tests

```bash
xcodebuild test -scheme BabyGuardian -destination 'platform=iOS Simulator,name=iPhone 14'
```

### Building for Release

```bash
xcodebuild archive -scheme BabyGuardian -archivePath ./build/BabyGuardian.xcarchive
```

## Contributing

This is a private project. For contributions, please contact the development team.

## License

Copyright © 2025 BabyGuardian. All rights reserved.

## Support

For support and inquiries, please contact the development team.

---

**Version**: 1.0.0  
**Last Updated**: September 2025

