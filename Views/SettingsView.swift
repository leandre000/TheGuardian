//
//  SettingsView.swift
//  BabyGuardian
//
//  App settings and configuration
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    @EnvironmentObject var alertManager: AlertManager
    @State private var selectedLanguage = "English"
    @State private var enableNotifications = true
    @State private var enableSoundAlerts = true
    
    let languages = ["English", "French", "Spanish", "Swahili", "Kinyarwanda"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Device Connection") {
                    HStack {
                        Text("Wearable Status")
                        Spacer()
                        HStack {
                            Circle()
                                .fill(healthMonitor.isConnected ? Color.green : Color.red)
                                .frame(width: 10, height: 10)
                            Text(healthMonitor.isConnected ? "Connected" : "Disconnected")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Button("Reconnect Device") {
                        healthMonitor.startMonitoring()
                    }
                }
                
                Section("Notifications") {
                    Toggle("Enable Notifications", isOn: $enableNotifications)
                    Toggle("Sound Alerts for Critical", isOn: $enableSoundAlerts)
                    
                    Picker("Alert Priority", selection: .constant("High & Critical")) {
                        Text("Critical Only").tag("Critical Only")
                        Text("High & Critical").tag("High & Critical")
                        Text("All Alerts").tag("All Alerts")
                    }
                }
                
                Section("Language") {
                    Picker("App Language", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                }
                
                Section("Health Thresholds") {
                    NavigationLink("Heart Rate Range") {
                        ThresholdSettingsView(title: "Heart Rate", unit: "BPM", min: 100, max: 160)
                    }
                    
                    NavigationLink("Temperature Range") {
                        ThresholdSettingsView(title: "Temperature", unit: "°C", min: 36.0, max: 38.0)
                    }
                    
                    NavigationLink("Oxygen Range") {
                        ThresholdSettingsView(title: "Oxygen Saturation", unit: "%", min: 95.0, max: 100.0)
                    }
                }
                
                Section("Data & Privacy") {
                    NavigationLink("Privacy Policy") {
                        Text("Privacy Policy Content")
                            .navigationTitle("Privacy Policy")
                    }
                    
                    NavigationLink("Data Export") {
                        Text("Export your data")
                            .navigationTitle("Data Export")
                    }
                    
                    Button("Clear All Data") {
                        // Clear data action
                    }
                    .foregroundColor(.red)
                }
                
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    NavigationLink("Terms of Service") {
                        Text("Terms of Service Content")
                            .navigationTitle("Terms of Service")
                    }
                    
                    NavigationLink("Support") {
                        Text("Contact Support")
                            .navigationTitle("Support")
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ThresholdSettingsView: View {
    let title: String
    let unit: String
    let min: Double
    let max: Double
    
    @State private var minValue: Double
    @State private var maxValue: Double
    
    init(title: String, unit: String, min: Double, max: Double) {
        self.title = title
        self.unit = unit
        self.min = min
        self.max = max
        _minValue = State(initialValue: min)
        _maxValue = State(initialValue: max)
    }
    
    var body: some View {
        Form {
            Section("Threshold Range") {
                VStack(alignment: .leading) {
                    Text("Minimum: \(String(format: "%.1f", minValue)) \(unit)")
                    Slider(value: $minValue, in: min...maxValue, step: 0.1)
                }
                
                VStack(alignment: .leading) {
                    Text("Maximum: \(String(format: "%.1f", maxValue)) \(unit)")
                    Slider(value: $maxValue, in: minValue...max, step: 0.1)
                }
            }
            
            Section {
                Button("Reset to Default") {
                    minValue = min
                    maxValue = max
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

