//
//  Theme.swift
//  BabyGuardian
//
//  App theming and color definitions
//

import SwiftUI

struct AppTheme {
    // Primary Colors
    static let primaryBlue = Color(red: 0.2, green: 0.4, blue: 0.8)
    static let primaryGreen = Color(red: 0.2, green: 0.7, blue: 0.4)
    
    // Alert Colors
    static let criticalRed = Color.red
    static let warningOrange = Color.orange
    static let infoBlue = Color.blue
    static let successGreen = Color.green
    
    // Background Colors
    static let backgroundLight = Color(.systemBackground)
    static let backgroundSecondary = Color(.systemGray6)
    
    // Text Colors
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary
    
    // Spacing
    static let spacingSmall: CGFloat = 8
    static let spacingMedium: CGFloat = 16
    static let spacingLarge: CGFloat = 24
    
    // Corner Radius
    static let cornerRadiusSmall: CGFloat = 8
    static let cornerRadiusMedium: CGFloat = 12
    static let cornerRadiusLarge: CGFloat = 16
}

