//
//  LoadingView.swift
//  BabyGuardian
//
//  Animated loading screen with logo
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    @State private var rotationAngle: Double = 0
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    
    var body: some View {
        ZStack {
            // Background
            Color.white
                .ignoresSafeArea()
            
            // Decorative circles
            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 200, height: 200)
                .offset(x: -150, y: -300)
            
            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 150, height: 150)
                .offset(x: -120, y: 400)
            
            Circle()
                .fill(Color(red: 1.0, green: 0.5, blue: 0.4).opacity(0.1))
                .frame(width: 180, height: 180)
                .offset(x: 150, y: 400)
            
            // Main content
            VStack(spacing: 30) {
                // Logo with animation
                ZStack {
                    // Shield shape
                    ShieldShape()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.blue,
                                    Color.blue.opacity(0.8)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 120, height: 140)
                        .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 10)
                    
                    // Baby face circle
                    Circle()
                        .fill(Color(red: 1.0, green: 0.7, blue: 0.6))
                        .frame(width: 60, height: 60)
                        .offset(y: -10)
                        .overlay(
                            // Baby face
                            VStack(spacing: 4) {
                                HStack(spacing: 8) {
                                    Circle()
                                        .fill(Color.black.opacity(0.6))
                                        .frame(width: 6, height: 6)
                                    Circle()
                                        .fill(Color.black.opacity(0.6))
                                        .frame(width: 6, height: 6)
                                }
                                .offset(y: 8)
                                
                                Rectangle()
                                    .fill(Color.black.opacity(0.4))
                                    .frame(width: 20, height: 2)
                                    .offset(y: 12)
                            }
                        )
                    
                    // Circuit lines
                    HStack(spacing: 0) {
                        ForEach(0..<3) { index in
                            HStack(spacing: 0) {
                                Rectangle()
                                    .fill(index == 0 ? Color.blue : Color(red: 1.0, green: 0.5, blue: 0.4))
                                    .frame(width: 30, height: 3)
                                
                                Circle()
                                    .fill(index == 0 ? Color.blue : Color(red: 1.0, green: 0.5, blue: 0.4))
                                    .frame(width: 8, height: 8)
                            }
                            .offset(x: index == 0 ? -50 : (index == 1 ? -25 : 0))
                        }
                    }
                    .offset(x: -80, y: 0)
                    .rotationEffect(.degrees(isAnimating ? 5 : -5))
                    .animation(
                        Animation.easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: true),
                        value: isAnimating
                    )
                }
                .scaleEffect(scale)
                .rotationEffect(.degrees(rotationAngle))
                .animation(
                    Animation.easeInOut(duration: 2.0)
                        .repeatForever(autoreverses: true),
                    value: scale
                )
                
                // Loading text
                Text("LOADING...")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.blue.opacity(0.8))
                    .opacity(opacity)
                    .animation(
                        Animation.easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true),
                        value: opacity
                    )
            }
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        isAnimating = true
        withAnimation(
            Animation.easeInOut(duration: 2.0)
                .repeatForever(autoreverses: true)
        ) {
            scale = 1.1
        }
        
        withAnimation(
            Animation.linear(duration: 3.0)
                .repeatForever(autoreverses: false)
        ) {
            rotationAngle = 360
        }
    }
}

struct ShieldShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        // Shield shape
        path.move(to: CGPoint(x: width / 2, y: height))
        
        // Left curve
        path.addCurve(
            to: CGPoint(x: width * 0.15, y: height * 0.3),
            control1: CGPoint(x: width * 0.3, y: height * 0.7),
            control2: CGPoint(x: width * 0.1, y: height * 0.5)
        )
        
        // Top left
        path.addCurve(
            to: CGPoint(x: width / 2, y: height * 0.05),
            control1: CGPoint(x: width * 0.2, y: height * 0.15),
            control2: CGPoint(x: width * 0.35, y: height * 0.08)
        )
        
        // Top right
        path.addCurve(
            to: CGPoint(x: width * 0.85, y: height * 0.3),
            control1: CGPoint(x: width * 0.65, y: height * 0.08),
            control2: CGPoint(x: width * 0.8, y: height * 0.15)
        )
        
        // Right curve
        path.addCurve(
            to: CGPoint(x: width / 2, y: height),
            control1: CGPoint(x: width * 0.9, y: height * 0.5),
            control2: CGPoint(x: width * 0.7, y: height * 0.7)
        )
        
        path.closeSubpath()
        
        return path
    }
}

