//
//  SignupParentView.swift
//  BabyGuardian
//
//  Sign up form - Step 1: Parent Information
//

import SwiftUI

struct SignupParentView: View {
    @Binding var currentStep: OnboardingState.OnboardingStep
    @EnvironmentObject var formData: SignupFormData
    @State private var showLogin = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Progress indicator
                        ProgressIndicator(currentStep: 1, totalSteps: 3, stepLabel: "Parent")
                            .padding(.top, 20)
                        
                        VStack(spacing: 20) {
                            // Full Name
                            CustomTextField(
                                title: "Full Name",
                                text: $formData.parentData.fullName,
                                placeholder: "Enter your full name",
                                icon: "person.fill"
                            )
                            
                            // Email
                            CustomTextField(
                                title: "Email",
                                text: $formData.parentData.email,
                                placeholder: "Enter your email",
                                icon: "envelope.fill",
                                keyboardType: .emailAddress
                            )
                            
                            // Phone Number
                            PhoneNumberField(
                                title: "Phone Number",
                                text: $formData.parentData.phoneNumber,
                                placeholder: "Enter phone number"
                            )
                            
                            // Password
                            SecureTextField(
                                title: "Password",
                                text: $formData.parentData.password,
                                placeholder: "Enter password"
                            )
                            
                            // Confirm Password
                            SecureTextField(
                                title: "Confirm Password",
                                text: $formData.parentData.confirmPassword,
                                placeholder: "Confirm password"
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        
                        // Login link
                        HStack {
                            Text("Already have an account?")
                                .foregroundColor(.secondary)
                            
                            Button(action: {
                                showLogin = true
                            }) {
                                Text("Login")
                                    .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                                    .fontWeight(.semibold)
                            }
                        }
                        .padding(.top, 8)
                        
                        // Next Button
                        Button(action: {
                            if validateParentData() {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    currentStep = .signupBaby
                                }
                            }
                        }) {
                            Text("Next")
                                .primaryButton()
                        }
                        .buttonPress()
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
                            currentStep = .features
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                }
            }
            .fullScreenCover(isPresented: $showLogin) {
                LoginView()
            }
        }
    }
    
    private func validateParentData() -> Bool {
        return !formData.parentData.fullName.isEmpty &&
               !formData.parentData.email.isEmpty &&
               !formData.parentData.phoneNumber.isEmpty &&
               !formData.parentData.password.isEmpty &&
               formData.parentData.password == formData.parentData.confirmPassword
    }
}

struct ProgressIndicator: View {
    let currentStep: Int
    let totalSteps: Int
    let stepLabel: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                ForEach(1...totalSteps, id: \.self) { step in
                    Circle()
                        .fill(step <= currentStep ? AppTheme.primaryOrange : Color.gray.opacity(0.3))
                        .frame(width: 12, height: 12)
                }
            }
            
            Text(stepLabel)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
        }
    }
}

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    let icon: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.secondary)
                    .frame(width: 20)
                
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

struct SecureTextField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.secondary)
            
            SecureField(placeholder, text: $text)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
        }
    }
}

struct PhoneNumberField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.secondary)
            
            HStack {
                // Flag icon placeholder
                Text("🇷🇼")
                    .font(.system(size: 24))
                    .frame(width: 40)
                
                TextField(placeholder, text: $text)
                    .keyboardType(.phonePad)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

