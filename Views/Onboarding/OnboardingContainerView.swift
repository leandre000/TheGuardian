//
//  OnboardingContainerView.swift
//  BabyGuardian
//
//  Main onboarding container that manages the flow
//

import SwiftUI

struct OnboardingContainerView: View {
    @StateObject private var onboardingState = OnboardingState()
    @StateObject private var signupData = SignupFormData()
    
    var body: some View {
        Group {
            if onboardingState.hasCompletedOnboarding {
                ContentView()
            } else {
                OnboardingFlowView()
                    .environmentObject(onboardingState)
                    .environmentObject(signupData)
            }
        }
    }
}

struct OnboardingFlowView: View {
    @EnvironmentObject var onboardingState: OnboardingState
    @EnvironmentObject var signupData: SignupFormData
    
    var body: some View {
        ZStack {
            switch onboardingState.currentStep {
            case .splash:
                SplashView(currentStep: $onboardingState.currentStep)
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .opacity
                    ))
                
            case .features:
                FeaturesView(currentStep: $onboardingState.currentStep)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                
            case .signupParent:
                SignupParentView(currentStep: $onboardingState.currentStep)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                
            case .signupBaby:
                SignupBabyView(currentStep: $onboardingState.currentStep)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                
            case .signupEmergency:
                SignupEmergencyView(currentStep: $onboardingState.currentStep)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                
            case .completed:
                ContentView()
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .opacity
                    ))
            }
        }
        .animation(AppAnimations.springSmooth, value: onboardingState.currentStep)
    }
}

