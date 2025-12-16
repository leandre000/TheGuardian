//
//  AppInfoView.swift
//  BabyGuardian
//
//  App Info & Support screen
//

import SwiftUI

struct AppInfoView: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Description
                    Text("Get help, learn about BabyGuardian, and manage your support options.")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    
                    // App Info Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("App Info")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            InfoRow(label: "App Name", value: "Baby Guardian")
                            Divider().padding(.leading, 20)
                            InfoRow(label: "Version", value: "1.3.2 (Latest)")
                            Divider().padding(.leading, 20)
                            InfoRow(label: "Build Number", value: "BG-1052025")
                            Divider().padding(.leading, 20)
                            InfoRow(label: "Release Date", value: "October 2025")
                            Divider().padding(.leading, 20)
                            InfoRow(label: "Developer", value: "Echosols, Rwanda")
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    
                    // Help & Support Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Help & Support")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            SupportOption(icon: "questionmark.circle.fill", title: "FAQs")
                            SupportOption(icon: "wrench.and.screwdriver.fill", title: "Device Setup")
                            SupportOption(icon: "book.fill", title: "User Guide")
                            SupportOption(icon: "brain.head.profile", title: "AI Insights Help")
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Legal & Policy Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Legal & Policy")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            SupportOption(icon: "lock.shield.fill", title: "Privacy Policy")
                            SupportOption(icon: "doc.text.fill", title: "Terms Of Use")
                            SupportOption(icon: "chart.bar.doc.horizontal.fill", title: "Transparency report")
                            SupportOption(icon: "cross.case.fill", title: "Medical Disclaimer")
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Contact Support Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Contact Support")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 12) {
                            Text("How can I help you?")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ContactOption(
                                icon: "message.fill",
                                title: "Chat With Us",
                                color: .blue
                            )
                            
                            ContactOption(
                                icon: "envelope.fill",
                                title: "Email",
                                value: "support@babyguardian.app",
                                color: .orange
                            )
                            
                            ContactOption(
                                icon: "phone.fill",
                                title: "Phone",
                                value: "+250 788 000 123",
                                color: .green
                            )
                        }
                        .padding(20)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    
                    // Community & Feedback Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Community & Feedback")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            CommunityRow(title: "Join Our Community")
                            Divider().padding(.leading, 20)
                            CommunityRow(title: "Submit Feedback", subtitle: "Tap to go")
                            Divider().padding(.leading, 20)
                            CommunityRow(title: "Rate The App", showStars: true)
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("App Info & Support")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 16))
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

struct SupportOption: View {
    let icon: String
    let title: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(AppTheme.primaryOrange)
                
                Text(title)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(12)
        }
    }
}

struct ContactOption: View {
    let icon: String
    let title: String
    var value: String? = nil
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    if let value = value {
                        Text(value)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
            }
            .padding(16)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(12)
        }
    }
}

struct CommunityRow: View {
    let title: String
    var subtitle: String? = nil
    var showStars: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.primary)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if showStars {
                HStack(spacing: 4) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star.fill")
                            .font(.system(size: 14))
                            .foregroundColor(AppTheme.primaryOrange)
                    }
                }
            } else {
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

