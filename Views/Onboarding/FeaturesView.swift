//
//  FeaturesView.swift
//  BabyGuardian
//
//  Features showcase screen with sign up/login options
//

import SwiftUI
import DesignSystem

struct FeaturesView: View {
    @Binding var currentStep: OnboardingState.OnboardingStep
    @State private var showLogin = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top image section
                ZStack {
                    // Background image placeholder
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.9, green: 0.95, blue: 1.0),
                            Color(red: 0.85, green: 0.9, blue: 0.95)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 350)
                    
                    VStack(spacing: 20) {
                        // Smart Baby Monitoring center icon
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 80, height: 80)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                            
                            Image(systemName: "heart.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                        }
                        
                        Text("Smart Baby Monitoring")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 60)
                    
                    // Feature icons around center
                    VStack {
                        HStack(spacing: 40) {
                            FeatureIcon(icon: "thermometer", color: .red)
                            Spacer()
                            FeatureIcon(icon: "heart.fill", color: .pink)
                        }
                        .padding(.horizontal, 60)
                        
                        Spacer()
                        
                        HStack(spacing: 40) {
                            FeatureIcon(icon: "bed.double.fill", color: .blue)
                            Spacer()
                            FeatureIcon(icon: "wifi", color: .green)
                        }
                        .padding(.horizontal, 60)
                        .padding(.bottom, 40)
                    }
                }
                
                // Features card
                VStack(alignment: .leading, spacing: 24) {
                    Text("Enjoy Smart Parenting")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.bottom, 8)
                    
                    FeatureRow(
                        number: "1",
                        title: "Health Tracking",
                        description: "Monitor heart rate, temperature & sleep"
                    )
                    
                    FeatureRow(
                        number: "2",
                        title: "Live Camera Feed",
                        description: "See your baby anytime"
                    )
                    
                    FeatureRow(
                        number: "3",
                        title: "Fall Detection Alerts",
                        description: "Get instant notifications for safety"
                    )
                }
                .padding(28)
                .background(Color(.systemBackground))
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: -5)
                .offset(y: -20)
                
                Spacer()
                
                // Action buttons
                VStack(spacing: 16) {
                    // Sign Up Button
                    Button(action: {
                        withAnimation(AppAnimations.springSmooth) {
                            currentStep = .signupParent
                        }
                    }) {
                        Text("Sign up")
                            .primaryButton()
                    }
                    .buttonPress()
                    
                    // Log In Button
                    Button(action: {
                        showLogin = true
                    }) {
                        Text("Log in")
                            .secondaryButton()
                    }
                    .buttonPress()
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
        }
            .fullScreenCover(isPresented: $showLogin) {
                LoginView()
            }
    }
}

struct FeatureIcon: View {
    let icon: String
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 50, height: 50)
            
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)
        }
    }
}

struct FeatureRow: View {
    let number: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Number circle
            ZStack {
                Circle()
                    .fill(AppTheme.primaryBlue)
                    .frame(width: 32, height: 32)
                
                Text(number)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login View")
                    .font(.title)
                // TODO: Implement login functionality
            }
            .navigationTitle("Log In")
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

