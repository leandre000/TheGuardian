//
//  UIEnhancements.swift
//  BabyGuardian
//
//  Enhanced UI components and modifiers
//

import SwiftUI

// MARK: - View Modifiers

extension View {
    func cardStyle() -> some View {
        self
            .padding(AppTheme.spacingMedium)
            .background(Color(.systemBackground))
            .cornerRadius(AppTheme.cornerRadiusMedium)
            .shadow(
                color: AppTheme.shadowMedium.color,
                radius: AppTheme.shadowMedium.radius,
                x: AppTheme.shadowMedium.x,
                y: AppTheme.shadowMedium.y
            )
    }
    
    func sectionHeader() -> some View {
        self
            .font(AppTheme.fontHeadline)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func primaryButton() -> some View {
        self
            .font(AppTheme.fontBodyBold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppTheme.spacingMedium)
            .background(AppTheme.orangeGradient)
            .cornerRadius(AppTheme.cornerRadiusMedium)
            .shadow(
                color: AppTheme.primaryOrange.opacity(0.4),
                radius: 15,
                x: 0,
                y: 8
            )
    }
    
    func secondaryButton() -> some View {
        self
            .font(AppTheme.fontBodyBold)
            .foregroundColor(AppTheme.primaryOrange)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppTheme.spacingMedium)
            .background(Color(.systemBackground))
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.cornerRadiusMedium)
                    .stroke(AppTheme.primaryOrange, lineWidth: 2)
            )
    }
}

// MARK: - Enhanced Components

struct EnhancedCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(AppTheme.spacingMedium)
            .background(Color(.systemBackground))
            .cornerRadius(AppTheme.cornerRadiusLarge)
            .shadow(
                color: AppTheme.shadowMedium.color,
                radius: AppTheme.shadowMedium.radius,
                x: AppTheme.shadowMedium.x,
                y: AppTheme.shadowMedium.y
            )
    }
}

struct SectionHeader: View {
    let title: String
    var action: (() -> Void)? = nil
    var actionTitle: String? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(AppTheme.fontHeadline)
                .foregroundColor(.primary)
            
            Spacer()
            
            if let action = action, let actionTitle = actionTitle {
                Button(action: action) {
                    Text(actionTitle)
                        .font(AppTheme.fontSubheadline)
                        .foregroundColor(AppTheme.primaryOrange)
                }
            }
        }
        .padding(.horizontal, AppTheme.spacingMedium)
    }
}

struct StatusBadge: View {
    let text: String
    let color: Color
    var isActive: Bool = true
    
    var body: some View {
        HStack(spacing: 6) {
            if isActive {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
            }
            Text(text)
                .font(AppTheme.fontCaption)
                .foregroundColor(isActive ? color : .secondary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(isActive ? color.opacity(0.1) : Color(.systemGray6))
        .cornerRadius(12)
    }
}

