//
//  SettingsMainView.swift
//  BabyGuardian
//
//  Main settings screen with categories
//

import SwiftUI

struct SettingsMainView: View {
    @State private var showMenu = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        SettingsCategoryRow(
                            icon: "person.fill",
                            title: "Account & Profile",
                            description: "Parent profile, Baby Profile...",
                            destination: AnyView(ProfileView())
                        )
                        
                        SettingsCategoryRow(
                            icon: "bell.fill",
                            title: "Notifications & Alerts",
                            description: "Alert sounds, push notifications, SMS...",
                            destination: AnyView(NotificationsAlertsView())
                        )
                        
                        SettingsCategoryRow(
                            icon: "ipad",
                            title: "Device Management",
                            description: "Connected Devices, Add New Device...",
                            destination: AnyView(DeviceManagementView())
                        )
                        
                        SettingsCategoryRow(
                            icon: "heart.fill",
                            title: "Health & Monitoring Preferences",
                            description: "Vitals Update, Temperature units,...",
                            destination: AnyView(HealthPreferencesView())
                        )
                        
                        SettingsCategoryRow(
                            icon: "brain",
                            title: "AI & Insights",
                            description: "Reset AI insights, Accuracy reports,...",
                            destination: AnyView(AIInsightsView())
                        )
                        
                        SettingsCategoryRow(
                            icon: "square.grid.2x2",
                            title: "App Info & Support",
                            description: "User Guide / FAQs, Contact Support...",
                            destination: AnyView(AppInfoView())
                        )
                        
                        SettingsCategoryRow(
                            icon: "shield.fill",
                            title: "Emergency Settings",
                            description: "Emergency Contacts, Auto-Call Options,...",
                            destination: AnyView(EmergencySettingsView())
                        )
                    }
                    .padding(.top, 8)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showMenu = true
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.primary)
                    }
                }
            }
            .sheet(isPresented: $showMenu) {
                SettingsMenuView()
            }
        }
    }
}

struct SettingsCategoryRow: View {
    let icon: String
    let title: String
    let description: String
    let destination: AnyView
    @State private var navigate = false
    
    var body: some View {
        Button(action: {
            navigate = true
        }) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    Circle()
                        .fill(AppTheme.primaryOrange.opacity(0.2))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(AppTheme.primaryOrange)
                }
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(.systemBackground))
        }
        .background(
            NavigationLink(destination: destination, isActive: $navigate) {
                EmptyView()
            }
            .hidden()
        )
    }
}

struct SettingsMenuView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Settings Menu")
                    .font(.title)
                    .padding()
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// Placeholder views for settings categories
struct DeviceManagementView: View {
    var body: some View {
        Text("Device Management")
            .navigationTitle("Device Management")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct HealthPreferencesView: View {
    var body: some View {
        Text("Health Preferences")
            .navigationTitle("Health & Monitoring")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AIInsightsView: View {
    var body: some View {
        Text("AI & Insights")
            .navigationTitle("AI & Insights")
            .navigationBarTitleDisplayMode(.inline)
    }
}


struct EmergencySettingsView: View {
    var body: some View {
        Text("Emergency Settings")
            .navigationTitle("Emergency Settings")
            .navigationBarTitleDisplayMode(.inline)
    }
}

