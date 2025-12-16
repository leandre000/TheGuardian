//
//  EmergencySettingsView.swift
//  BabyGuardian
//
//  Emergency Settings screen
//

import SwiftUI
import DesignSystem

struct EmergencySettingsView: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    Text("Emergency Settings")
                        .font(AppTheme.fontTitle)
                        .padding(.top, 20)
                    
                    Text("Configure emergency contacts and auto-call options")
                        .font(AppTheme.fontSubheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
            }
        }
        .navigationTitle("Emergency Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

