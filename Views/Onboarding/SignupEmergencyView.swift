//
//  SignupEmergencyView.swift
//  BabyGuardian
//
//  Sign up form - Step 3: Emergency Contacts & Consent
//

import SwiftUI

struct SignupEmergencyView: View {
    @Binding var currentStep: OnboardingState.OnboardingStep
    @EnvironmentObject var formData: SignupFormData
    @EnvironmentObject var onboardingState: OnboardingState
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Progress indicator
                        ProgressIndicator(currentStep: 3, totalSteps: 3, stepLabel: "Emergency contacts")
                            .padding(.top, 20)
                        
                        VStack(spacing: 20) {
                            // Emergency Contact Name
                            CustomTextField(
                                title: "Name",
                                text: $formData.emergencyData.name,
                                placeholder: "Enter contact name",
                                icon: "person.fill"
                            )
                            
                            // Relationship
                            PickerField(
                                title: "Relationship",
                                selection: $formData.emergencyData.relationship,
                                options: EmergencyContactData.Relationship.allCases
                            )
                            
                            // Phone Number
                            PhoneNumberField(
                                title: "Phone Number",
                                text: $formData.emergencyData.phoneNumber,
                                placeholder: "Enter phone number"
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        
                        // Consent checkboxes
                        VStack(alignment: .leading, spacing: 16) {
                            ConsentCheckbox(
                                isChecked: $formData.consentData.dataCollectionConsent,
                                text: "I consent to the collection and processing of my personal data for the purpose of providing baby monitoring services."
                            )
                            
                            ConsentCheckbox(
                                isChecked: $formData.consentData.privacyPolicyConsent,
                                text: "I have read and agree to the Privacy Policy and Terms of Service."
                            )
                            
                            ConsentCheckbox(
                                isChecked: $formData.consentData.monitoringAssistantConsent,
                                text: "I understand that this app is a monitoring assistant and not a substitute for professional medical care."
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 8)
                        
                        // Finish Button
                        Button(action: {
                            if validateEmergencyData() {
                                // Complete onboarding
                                onboardingState.hasCompletedOnboarding = true
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    currentStep = .completed
                                }
                            }
                        }) {
                            Text("Finish")
                                .primaryButton()
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation {
                            currentStep = .signupBaby
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
    
    private func validateEmergencyData() -> Bool {
        return !formData.emergencyData.name.isEmpty &&
               !formData.emergencyData.phoneNumber.isEmpty &&
               formData.consentData.dataCollectionConsent &&
               formData.consentData.privacyPolicyConsent &&
               formData.consentData.monitoringAssistantConsent
    }
}

struct ConsentCheckbox: View {
    @Binding var isChecked: Bool
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button(action: {
                isChecked.toggle()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(isChecked ? Color(red: 1.0, green: 0.6, blue: 0.0) : Color.clear)
                        .frame(width: 24, height: 24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(isChecked ? Color(red: 1.0, green: 0.6, blue: 0.0) : Color.gray.opacity(0.4), lineWidth: 2)
                        )
                    
                    if isChecked {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

