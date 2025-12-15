//
//  SplashView.swift
//  BabyGuardian
//
//  Onboarding splash screen - "Your Baby Always in Sight"
//

import SwiftUI

struct SplashView: View {
    @Binding var currentStep: OnboardingState.OnboardingStep
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.95, green: 0.97, blue: 1.0),
                    Color(red: 0.9, green: 0.95, blue: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Baby image placeholder (in production, use actual image)
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.85, green: 0.9, blue: 0.95),
                                    Color(red: 0.75, green: 0.85, blue: 0.95)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 280, height: 280)
                        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                    
                    Image(systemName: "face.smiling")
                        .font(.system(size: 120))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 40)
                
                // Title
                HStack(spacing: 12) {
                    Text("Your")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 8) {
                        Text("Baby")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                        
                        Image(systemName: "eye.fill")
                            .font(.system(size: 32))
                            .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                    }
                }
                .padding(.bottom, 8)
                
                // Subtitle
                Text("Always in Sight")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.secondary)
                    .padding(.bottom, 60)
                
                Spacer()
                
                // Get Started Button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentStep = .features
                    }
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 18, weight: .semibold))
                        
                        Text("Get Started")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 1.0, green: 0.6, blue: 0.0),
                                Color(red: 1.0, green: 0.5, blue: 0.0)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
                    .shadow(color: Color(red: 1.0, green: 0.6, blue: 0.0).opacity(0.4), radius: 15, x: 0, y: 8)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }
    }
}

