//
//  HealthPreferencesView.swift
//  BabyGuardian
//
//  Health & Monitoring Preferences screen
//

import SwiftUI

struct HealthPreferencesView: View {
    @State private var temperatureTracking = true
    @State private var heartRateMonitoring = true
    @State private var oxygenTracking = true
    @State private var sleepQualityTracking = true
    @State private var roomTemperature = true
    @State private var airQuality = true
    @State private var bedEdgeSensor = true
    @State private var sendContinuous = false
    @State private var bedEdgeSensitivity = "Medium"
    @State private var alertSoundSensitivity = "Medium"
    @State private var prioritySensitivity = "Low"
    @State private var fallDetection = true
    @State private var gasSmokeAlert = true
    @State private var cryDetection = true
    @State private var lowBattery = true
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Description
                    Text("Customize what BabyGuardian tracks and how you receive alerts.")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    
                    // Vital Signs Monitoring Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Vital Signs Monitoring")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            PreferenceRow(
                                icon: "thermometer",
                                title: "Temperature tracking",
                                description: "Alert if >38C / <35C, customize threshold",
                                isEnabled: $temperatureTracking
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            PreferenceRow(
                                icon: "heart.fill",
                                title: "Heart Rate Monitoring",
                                description: "Normal range (90-180 bpm), input field",
                                isEnabled: $heartRateMonitoring
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            PreferenceRowWithCheckbox(
                                icon: "lungs.fill",
                                title: "Oxygen (SpO2) Tracking",
                                description: "Alert if <92%",
                                isEnabled: $oxygenTracking,
                                checkboxLabel: "Send continuous",
                                checkboxValue: $sendContinuous
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            PreferenceRow(
                                icon: "bed.double.fill",
                                title: "Sleep Quality Tracking",
                                description: "Include movement & breathing pattern",
                                isEnabled: $sleepQualityTracking
                            )
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    
                    // Room Conditions Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Room Conditions")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            PreferenceRow(
                                icon: "thermometer",
                                title: "Temperature & Humidity",
                                description: "Alert if too hot/cold, input range fields",
                                isEnabled: $roomTemperature
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            PreferenceRow(
                                icon: "cloud.fill",
                                title: "Air Quality / Gas Detection",
                                description: "Notify if gas or smoke detected",
                                isEnabled: $airQuality
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            PreferenceRowWithPicker(
                                icon: "exclamationmark.triangle.fill",
                                title: "Bed Edge Sensor",
                                description: "Sensitivity",
                                isEnabled: $bedEdgeSensor,
                                pickerValue: $bedEdgeSensitivity,
                                options: ["Low", "Medium", "High"]
                            )
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    
                    // Notifications & Sounds Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Notifications & Sounds")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            PreferenceRowWithPicker(
                                icon: "bell.fill",
                                title: "Alert Sound Type",
                                description: "Sensitivity",
                                isEnabled: .constant(true),
                                pickerValue: $alertSoundSensitivity,
                                options: ["Low", "Medium", "High"],
                                showChevron: true,
                                chevronText: "Chime"
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            PreferenceRowWithCheckboxes(
                                icon: "heart.fill",
                                title: "Priority Alerts",
                                description: "Sensitivity",
                                pickerValue: $prioritySensitivity,
                                options: ["Low", "Medium"],
                                checkboxes: [
                                    ("Fall Detection", $fallDetection),
                                    ("Gas \\ Smoke Alert", $gasSmokeAlert),
                                    ("Cry Detection", $cryDetection),
                                    ("Low Battery", $lowBattery)
                                ]
                            )
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("Health & Monitoring Preferences")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                }
            }
        }
    }
}

struct PreferenceRow: View {
    let icon: String
    let title: String
    let description: String
    @Binding var isEnabled: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
            
            Toggle("", isOn: $isEnabled)
                .labelsHidden()
                .tint(Color(red: 1.0, green: 0.6, blue: 0.0))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

struct PreferenceRowWithCheckbox: View {
    let icon: String
    let title: String
    let description: String
    @Binding var isEnabled: Bool
    let checkboxLabel: String
    @Binding var checkboxValue: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Toggle("", isOn: $isEnabled)
                    .labelsHidden()
                    .tint(Color(red: 1.0, green: 0.6, blue: 0.0))
            }
            
            if isEnabled {
                HStack {
                    Spacer()
                        .frame(width: 40)
                    
                    Toggle(checkboxLabel, isOn: $checkboxValue)
                        .tint(Color(red: 1.0, green: 0.6, blue: 0.0))
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

struct PreferenceRowWithPicker: View {
    let icon: String
    let title: String
    let description: String
    @Binding var isEnabled: Bool
    @Binding var pickerValue: String
    let options: [String]
    var showChevron: Bool = false
    var chevronText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if !showChevron {
                    Toggle("", isOn: $isEnabled)
                        .labelsHidden()
                        .tint(Color(red: 1.0, green: 0.6, blue: 0.0))
                }
            }
            
            if isEnabled || showChevron {
                HStack {
                    Spacer()
                        .frame(width: 40)
                    
                    HStack {
                        Picker("", selection: $pickerValue) {
                            ForEach(options, id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        if showChevron {
                            Spacer()
                            Text(chevronText)
                                .foregroundColor(.secondary)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

struct PreferenceRowWithCheckboxes: View {
    let icon: String
    let title: String
    let description: String
    @Binding var pickerValue: String
    let options: [String]
    let checkboxes: [(String, Binding<Bool>)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            HStack {
                Spacer()
                    .frame(width: 40)
                
                Picker("", selection: $pickerValue) {
                    ForEach(options, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(.menu)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(checkboxes.enumerated()), id: \.offset) { index, checkbox in
                    HStack {
                        Spacer()
                            .frame(width: 40)
                        
                        Toggle(checkbox.0, isOn: checkbox.1)
                            .tint(Color(red: 1.0, green: 0.6, blue: 0.0))
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

