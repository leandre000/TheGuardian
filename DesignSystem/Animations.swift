//
//  Animations.swift
//  BabyGuardian
//
//  Professional animation system for smooth UI/UX
//

import SwiftUI

// MARK: - Animation Constants

struct AppAnimations {
    // Timing
    static let quick: Animation = .easeInOut(duration: 0.2)
    static let standard: Animation = .easeInOut(duration: 0.3)
    static let smooth: Animation = .easeInOut(duration: 0.4)
    static let slow: Animation = .easeInOut(duration: 0.6)
    
    // Spring Animations
    static let springBouncy: Animation = .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)
    static let springSmooth: Animation = .spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0)
    static let springGentle: Animation = .spring(response: 0.6, dampingFraction: 0.9, blendDuration: 0)
    
    // Easing
    static let easeOut: Animation = .easeOut(duration: 0.3)
    static let easeIn: Animation = .easeIn(duration: 0.3)
}

// MARK: - View Modifiers for Animations

extension View {
    /// Fade in animation
    func fadeIn(delay: Double = 0) -> some View {
        self.modifier(FadeInModifier(delay: delay))
    }
    
    /// Slide in from edge
    func slideIn(from edge: Edge, delay: Double = 0) -> some View {
        self.modifier(SlideInModifier(edge: edge, delay: delay))
    }
    
    /// Scale in animation
    func scaleIn(delay: Double = 0) -> some View {
        self.modifier(ScaleInModifier(delay: delay))
    }
    
    /// Bounce in animation
    func bounceIn(delay: Double = 0) -> some View {
        self.modifier(BounceInModifier(delay: delay))
    }
    
    /// Shimmer effect
    func shimmer() -> some View {
        self.modifier(ShimmerModifier())
    }
    
    /// Pulse animation
    func pulse(scale: CGFloat = 1.1) -> some View {
        self.modifier(PulseModifier(scale: scale))
    }
    
    /// Button press animation
    func buttonPress() -> some View {
        self.modifier(ButtonPressModifier())
    }
}

// MARK: - Animation Modifiers

struct FadeInModifier: ViewModifier {
    @State private var opacity: Double = 0
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .onAppear {
                withAnimation(AppAnimations.standard.delay(delay)) {
                    opacity = 1
                }
            }
    }
}

struct SlideInModifier: ViewModifier {
    @State private var offset: CGFloat = 0
    let edge: Edge
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .offset(x: edge == .leading ? -offset : (edge == .trailing ? offset : 0),
                   y: edge == .top ? -offset : (edge == .bottom ? offset : 0))
            .onAppear {
                offset = 100
                withAnimation(AppAnimations.springSmooth.delay(delay)) {
                    offset = 0
                }
            }
    }
}

struct ScaleInModifier: ViewModifier {
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(AppAnimations.springBouncy.delay(delay)) {
                    scale = 1
                    opacity = 1
                }
            }
    }
}

struct BounceInModifier: ViewModifier {
    @State private var scale: CGFloat = 0
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onAppear {
                withAnimation(AppAnimations.springBouncy.delay(delay)) {
                    scale = 1
                }
            }
    }
}

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0),
                        Color.white.opacity(0.3),
                        Color.white.opacity(0)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(x: phase)
                .animation(
                    Animation.linear(duration: 1.5)
                        .repeatForever(autoreverses: false),
                    value: phase
                )
            )
            .onAppear {
                phase = 300
            }
    }
}

struct PulseModifier: ViewModifier {
    @State private var isPulsing = false
    let scale: CGFloat
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? scale : 1.0)
            .animation(
                Animation.easeInOut(duration: 1.0)
                    .repeatForever(autoreverses: true),
                value: isPulsing
            )
            .onAppear {
                isPulsing = true
            }
    }
}

struct ButtonPressModifier: ViewModifier {
    @State private var isPressed = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(AppAnimations.quick, value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        isPressed = true
                    }
                    .onEnded { _ in
                        isPressed = false
                    }
            )
    }
}

// MARK: - Staggered List Animation

struct StaggeredListModifier: ViewModifier {
    let index: Int
    @State private var opacity: Double = 0
    @State private var offset: CGFloat = 20
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(y: offset)
            .onAppear {
                let delay = Double(index) * 0.1
                withAnimation(AppAnimations.springSmooth.delay(delay)) {
                    opacity = 1
                    offset = 0
                }
            }
    }
}

extension View {
    func staggered(index: Int) -> some View {
        self.modifier(StaggeredListModifier(index: index))
    }
}

// MARK: - Page Transition

struct PageTransition: ViewModifier {
    let isActive: Bool
    
    func body(content: Content) -> some View {
        content
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
            .animation(AppAnimations.smooth, value: isActive)
    }
}

// MARK: - Card Hover Effect

struct CardHoverModifier: ViewModifier {
    @State private var isHovered = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isHovered ? 1.02 : 1.0)
            .shadow(
                color: isHovered ? Color.black.opacity(0.15) : Color.black.opacity(0.1),
                radius: isHovered ? 12 : 8,
                x: 0,
                y: isHovered ? 6 : 4
            )
            .animation(AppAnimations.springSmooth, value: isHovered)
            .onTapGesture {
                withAnimation(AppAnimations.quick) {
                    isHovered = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(AppAnimations.quick) {
                        isHovered = false
                    }
                }
            }
    }
}

extension View {
    func cardHover() -> some View {
        self.modifier(CardHoverModifier())
    }
}

// MARK: - Loading Spinner

struct LoadingSpinner: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(
                AppTheme.primaryOrange,
                style: StrokeStyle(lineWidth: 3, lineCap: .round)
            )
            .frame(width: 24, height: 24)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1.0)
                        .repeatForever(autoreverses: false)
                ) {
                    rotation = 360
                }
            }
    }
}

// MARK: - Skeleton Loader

struct SkeletonLoader: View {
    @State private var shimmerOffset: CGFloat = -200
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.2))
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.clear,
                        Color.white.opacity(0.3),
                        Color.clear
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(x: shimmerOffset)
            )
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1.5)
                        .repeatForever(autoreverses: false)
                ) {
                    shimmerOffset = 400
                }
            }
    }
}

// MARK: - Ripple Effect

struct RippleEffect: ViewModifier {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.5
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(opacity), lineWidth: 2)
                    .scaleEffect(scale)
                    .animation(
                        Animation.easeOut(duration: 0.6)
                            .repeatForever(autoreverses: false),
                        value: scale
                    )
            )
            .onAppear {
                scale = 1.5
                opacity = 0
            }
    }
}

extension View {
    func ripple() -> some View {
        self.modifier(RippleEffect())
    }
}

