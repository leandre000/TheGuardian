//
//  Theme.swift
//  BabyGuardian
//
//  App theming and color definitions
//

import SwiftUI

struct AppTheme {
    // Primary Brand Colors
    static let primaryOrange = Color(red: 1.0, green: 0.6, blue: 0.0)
    static let primaryOrangeDark = Color(red: 1.0, green: 0.5, blue: 0.0)
    static let primaryBlue = Color(red: 0.2, green: 0.5, blue: 0.9)
    static let primaryGreen = Color(red: 0.2, green: 0.7, blue: 0.4)
    
    // Alert Colors
    static let criticalRed = Color.red
    static let warningOrange = Color(red: 1.0, green: 0.6, blue: 0.0)
    static let infoBlue = Color(red: 0.2, green: 0.5, blue: 0.9)
    static let successGreen = Color.green
    
    // Background Colors
    static let backgroundLight = Color(.systemBackground)
    static let backgroundSecondary = Color(.systemGroupedBackground)
    static let backgroundTertiary = Color(.systemGray6)
    
    // Text Colors
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary
    static let textTertiary = Color(.tertiaryLabel)
    
    // Gradient Colors
    static let orangeGradient = LinearGradient(
        gradient: Gradient(colors: [primaryOrange, primaryOrangeDark]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let blueGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 0.2, green: 0.5, blue: 0.9),
            Color(red: 0.3, green: 0.6, blue: 1.0)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Spacing System
    static let spacingXS: CGFloat = 4
    static let spacingSmall: CGFloat = 8
    static let spacingMedium: CGFloat = 16
    static let spacingLarge: CGFloat = 24
    static let spacingXL: CGFloat = 32
    
    // Corner Radius System
    static let cornerRadiusSmall: CGFloat = 8
    static let cornerRadiusMedium: CGFloat = 12
    static let cornerRadiusLarge: CGFloat = 16
    static let cornerRadiusXL: CGFloat = 20
    
    // Typography
    static let fontLargeTitle: Font = .system(size: 34, weight: .bold)
    static let fontTitle: Font = .system(size: 28, weight: .bold)
    static let fontTitle2: Font = .system(size: 22, weight: .bold)
    static let fontHeadline: Font = .system(size: 20, weight: .semibold)
    static let fontBody: Font = .system(size: 16, weight: .regular)
    static let fontBodyBold: Font = .system(size: 16, weight: .semibold)
    static let fontSubheadline: Font = .system(size: 15, weight: .regular)
    static let fontCaption: Font = .system(size: 12, weight: .regular)
    
    // Shadow
    static let shadowSmall = Shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    static let shadowMedium = Shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    static let shadowLarge = Shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 4)
}

struct Shadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
}

