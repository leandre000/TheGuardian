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
                    Label("Monitor", systemImage: "heart.fill")
                }
                .tag(1)
            
            CameraOverviewView()
                .tabItem {
                    Label("Camera", systemImage: "video.fill")
                }
                .tag(2)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(3)
        }
        .accentColor(Color(red: 1.0, green: 0.6, blue: 0.0))
    }
}

