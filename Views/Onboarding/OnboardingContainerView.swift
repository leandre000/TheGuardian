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
                    .transition(.opacity)
                
            case .features:
                FeaturesView(currentStep: $onboardingState.currentStep)
                    .transition(.move(edge: .trailing))
                
            case .signupParent:
                SignupParentView(currentStep: $onboardingState.currentStep)
                    .transition(.move(edge: .trailing))
                
            case .signupBaby:
                SignupBabyView(currentStep: $onboardingState.currentStep)
                    .transition(.move(edge: .trailing))
                
            case .signupEmergency:
                SignupEmergencyView(currentStep: $onboardingState.currentStep)
                    .transition(.move(edge: .trailing))
                
            case .completed:
                ContentView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: onboardingState.currentStep)
    }
}

