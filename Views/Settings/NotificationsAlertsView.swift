//
//  NotificationsAlertsView.swift
//  BabyGuardian
//
//  Notifications & Alerts settings screen
//

import SwiftUI

struct NotificationsAlertsView: View {
    @State private var healthAlerts = true
    @State private var safetyAlerts = true
    @State private var cryDetectionAlerts = true
    @State private var environmentAlerts = true
    @State private var aiInsightsAlerts = true
    @State private var vibration = true
    @State private var emailAlerts = true
    @State private var pushNotifications = true
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Alert Types Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Alert Types")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        
                        VStack(spacing: 0) {
                            AlertTypeRow(
                                icon: "heart.fill",
                                iconColor: .red,
                                title: "Health Alerts",
                                description: "Notify me if temperature, heart rate, or oxygen level is abnormal",
                                isEnabled: $healthAlerts
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            AlertTypeRow(
                                icon: "bed.double.fill",
                                iconColor: .blue,
                                title: "Safety Alerts",
                                description: "Warn me about bed-edge danger or unsafe room conditions",
                                isEnabled: $safetyAlerts
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            AlertTypeRow(
                                icon: "waveform",
                                iconColor: .orange,
                                title: "Cry Detection Alerts",
                                description: "Alert me when the baby cries for more than 10 seconds",
                                isEnabled: $cryDetectionAlerts
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            AlertTypeRow(
                                icon: "thermometer",
                                iconColor: .purple,
                                title: "Environment Alerts",
                                description: "Notify me if room temperature or air quality is unsafe.",
                                isEnabled: $environmentAlerts
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            AlertTypeRow(
                                icon: "brain",
                                iconColor: .red,
                                title: "AI Insights Alerts",
                                description: "Notify me when new health predictions are available",
                                isEnabled: $aiInsightsAlerts
                            )
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                    }
                    
                    // Alert Delivery Preferences Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Alert Delivery Preferences")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                            .padding(.top, 32)
                        
                        VStack(spacing: 0) {
                            HStack {
                                Text("Alert Sound")
                                    .font(.system(size: 16))
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Button(action: {}) {
                                    Text("Change Sound")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            
                            Divider()
                                .padding(.leading, 20)
                            
                            ToggleRow(
                                title: "Vibration",
                                isEnabled: $vibration
                            )
                            
                            Divider()
                                .padding(.leading, 20)
                            
                            ToggleRow(
                                title: "Email Alerts",
                                isEnabled: $emailAlerts
                            )
                            
                            Divider()
                                .padding(.leading, 20)
                            
                            ToggleRow(
                                title: "Push Notifications",
                                isEnabled: $pushNotifications
                            )
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("Notifications & Alerts")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Text("Manage Categories")
                        .font(.system(size: 16))
                        .foregroundColor(.green)
                }
            }
        }
    }
}

struct AlertTypeRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String
    @Binding var isEnabled: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(iconColor)
            }
            
            // Content
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
            
            // Toggle
            Toggle("", isOn: $isEnabled)
                .labelsHidden()
                .tint(Color(red: 1.0, green: 0.6, blue: 0.0))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

struct ToggleRow: View {
    let title: String
    @Binding var isEnabled: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.primary)
            
            Spacer()
            
            Toggle("", isOn: $isEnabled)
                .labelsHidden()
                .tint(Color(red: 1.0, green: 0.6, blue: 0.0))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

