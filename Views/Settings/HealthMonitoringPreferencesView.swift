//
//  HealthMonitoringPreferencesView.swift
//  BabyGuardian
//
//  Health & monitoring preferences screen
//

import SwiftUI

struct HealthMonitoringPreferencesView: View {
    @State private var temperatureTracking = true
    @State private var heartRateMonitoring = true
    @State private var oxygenTracking = true
    @State private var sleepTracking = true
    
    @State private var roomTempHumidity = true
    @State private var airQuality = true
    @State private var bedEdgeSensor = true
    
    @State private var alertSoundType = "Chime"
    @State private var priorityFall = true
    @State private var priorityGas = true
    @State private var priorityCry = true
    @State private var priorityLowBattery = true
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Health & Monitoring Preferences")
                            .font(.system(size: 22, weight: .bold))
                            .padding(.top, 12)
                        
                        Text("Customize what BabyGuardian tracks and how you receive alerts.")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    
                    // Vital Signs Monitoring
                    PreferenceCard(title: "Vital Signs Monitoring") {
                        ToggleRow(title: "Temperature tracking", subtitle: "Alert if > 38°C, auto-update threshold", isOn: $temperatureTracking)
                        
                        Divider().padding(.leading, 20)
                        
                        ToggleRow(title: "Heart Rate Monitoring", subtitle: "Normal range 100 - 160 bpm | adjust levels", isOn: $heartRateMonitoring)
                        
                        Divider().padding(.leading, 20)
                        
                        ToggleRow(title: "Oxygen (SpO₂) Tracking", subtitle: "Alert if < 95%, check once/10s, continuous", isOn: $oxygenTracking)
                        
                        Divider().padding(.leading, 20)
                        
                        ToggleRow(title: "Sleep Quality Tracking", subtitle: "Include movement & breathing pattern", isOn: $sleepTracking)
                    }
                    
                    // Room Conditions
                    PreferenceCard(title: "Room Conditions") {
                        ToggleRow(title: "Temperature & Humidity", subtitle: "Alert if too hot/cold, input range fields", isOn: $roomTempHumidity)
                        
                        Divider().padding(.leading, 20)
                        
                        ToggleRow(title: "Air Quality / Gas Detection", subtitle: "Notify if gas or smoke detected", isOn: $airQuality)
                        
                        Divider().padding(.leading, 20)
                        
                        ToggleRow(title: "Bed Edge Sensor", subtitle: "Sensitivity: Low / Medium / High", isOn: $bedEdgeSensor)
                    }
                    
                    // Notifications & Sounds
                    PreferenceCard(title: "Notifications & Sounds") {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Alert Sound Type")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Sensitivity: Low / Medium | Normal | High")
                                    .font(.system(size: 13))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Button(action: {}) {
                                HStack(spacing: 4) {
                                    Text(alertSoundType)
                                        .font(.system(size: 14, weight: .semibold))
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12, weight: .bold))
                                }
                                .foregroundColor(.primary)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        
                        Divider().padding(.leading, 20)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Priority Alerts")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.horizontal, 20)
                                .padding(.top, 4)
                            
                            PriorityToggleRow(title: "Fall Detection", isOn: $priorityFall)
                            PriorityToggleRow(title: "Gas / Smoke Alert", isOn: $priorityGas)
                            PriorityToggleRow(title: "Cry Detection", isOn: $priorityCry)
                            PriorityToggleRow(title: "Low Battery", isOn: $priorityLowBattery)
                        }
                        .padding(.bottom, 8)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("Health & Monitoring")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PreferenceCard<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 12)
            
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
    }
}

struct ToggleRow: View {
    let title: String
    let subtitle: String?
    @Binding var isOn: Bool
    
    init(title: String, subtitle: String? = nil, isOn: Binding<Bool>) {
        self.title = title
        self.subtitle = subtitle
        self._isOn = isOn
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(Color(red: 1.0, green: 0.6, blue: 0.0))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
}

struct PriorityToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 15))
                .foregroundColor(.primary)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(Color(red: 1.0, green: 0.6, blue: 0.0))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}


