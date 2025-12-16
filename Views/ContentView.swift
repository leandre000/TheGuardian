//
//  ContentView.swift
//  BabyGuardian
//
//  Main content view with tab navigation
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            EnhancedDashboardView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            DetailedMonitoringView()
                .tabItem {
                    Label("Health Stats", systemImage: "heart.fill")
                }
                .tag(1)
            
            NotificationsView()
                .tabItem {
                    Label("Alerts", systemImage: "bell.fill")
                }
                .tag(2)
            
            SettingsMainView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(3)
        }
        .accentColor(AppTheme.primaryOrange)
        .animation(AppAnimations.springSmooth, value: selectedTab)
    }
}

