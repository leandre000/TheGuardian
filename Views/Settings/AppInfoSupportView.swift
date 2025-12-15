//
//  AppInfoSupportView.swift
//  BabyGuardian
//
//  App info and support screen
//

import SwiftUI

struct AppInfoSupportView: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("App Info & Support")
                            .font(.system(size: 22, weight: .bold))
                        Text("Get help, learn about BabyGuardian, and manage your support options.")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    // App Details
                    AppDetailsCard()
                    
                    // Help & Support / Legal & Policy
                    TwoColumnCard(
                        leftTitle: "Help & Support",
                        leftItems: [
                            ("questionmark.circle", "FAQs"),
                            ("gearshape", "Device Setup"),
                            ("doc.text", "User Guide"),
                            ("waveform.path.ecg", "AI Insights Help")
                        ],
                        rightTitle: "Legal & Policy",
                        rightItems: [
                            ("lock.shield", "Privacy Policy"),
                            ("doc.text.fill", "Terms of Use"),
                            ("doc.text.magnifyingglass", "Transparency report"),
                            ("cross.case.fill", "Medical Disclaimer")
                        ]
                    )
                    
                    // Contact Support
                    ContactSupportCard()
                    
                    // Community
                    CommunityCard()
                }
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("App Info & Support")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AppDetailsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            DetailRow(label: "App Name", value: "Baby Guardian")
            DetailRow(label: "Version", value: "1.3.2 (latest)")
            DetailRow(label: "Build Number", value: "#BG-102525")
            DetailRow(label: "Release Date", value: "October 2025")
            DetailRow(label: "Developer", value: "Ecohubs, Rwanda")
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 20)
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
        }
    }
}

struct TwoColumnCard: View {
    let leftTitle: String
    let leftItems: [(String, String)]
    let rightTitle: String
    let rightItems: [(String, String)]
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 12) {
                Text(leftTitle)
                    .font(.system(size: 16, weight: .semibold))
                
                ForEach(leftItems, id: \.1) { item in
                    RowLink(icon: item.0, title: item.1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(rightTitle)
                    .font(.system(size: 16, weight: .semibold))
                
                ForEach(rightItems, id: \.1) { item in
                    RowLink(icon: item.0, title: item.1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(16)
        }
        .padding(.horizontal, 20)
    }
}

struct RowLink: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.secondary)
            Text(title)
                .font(.system(size: 14, weight: .medium))
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.secondary)
        }
    }
}

struct ContactSupportCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Contact Support")
                .font(.system(size: 18, weight: .bold))
            
            VStack(spacing: 12) {
                SupportRow(icon: "message.fill", title: "Chat with us", detail: "support@babyguardian.app")
                SupportRow(icon: "envelope.fill", title: "Email Support", detail: "support@babyguardian.app")
                SupportRow(icon: "phone.fill", title: "Call us", detail: "+250 788 000 123")
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 20)
    }
}

struct SupportRow: View {
    let icon: String
    let title: String
    let detail: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                Text(detail)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct CommunityCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Community & Feedback")
                .font(.system(size: 18, weight: .bold))
            
            VStack(spacing: 12) {
                RowLink(icon: "person.3.fill", title: "Join Our Community")
                RowLink(icon: "paperplane.fill", title: "Submit Feedback")
                HStack {
                    RowLink(icon: "star.fill", title: "Rate The App")
                    Spacer()
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
    }
}


