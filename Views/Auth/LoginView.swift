//
//  LoginView.swift
//  BabyGuardian
//
//  Login screen with email/password and social login
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email: String = "laetitia221@gmail.com"
    @State private var password: String = ""
    @State private var showForgotPassword = false
    @State private var showSignup = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background with cloud graphics
                BackgroundCloudView()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 32) {
                        // Logo/Title
                        VStack(spacing: 12) {
                            Image(systemName: "heart.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                            
                            Text("BabyGuardian")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.primary)
                        }
                        .padding(.top, 60)
                        
                        // Login Form
                        VStack(spacing: 20) {
                            // Email Field
                            CustomTextField(
                                title: "Email",
                                text: $email,
                                placeholder: "Enter your email",
                                icon: "envelope.fill",
                                keyboardType: .emailAddress
                            )
                            
                            // Password Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.secondary)
                                
                                HStack {
                                    SecureField("Enter your password", text: $password)
                                    
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                            }
                            
                            // Forgot Password Link
                            HStack {
                                Spacer()
                            Button(action: {
                                showForgotPassword = true
                            }) {
                                Text("Forgot Password?")
                                    .font(.system(size: 15))
                                    .foregroundColor(AppTheme.primaryOrange)
                            }
                            }
                            
                            // Log In Button
                            Button(action: {
                                // Handle login
                                dismiss()
                            }) {
                                Text("Log In")
                                    .primaryButton()
                            }
                            .padding(.top, 8)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 40)
                        
                        // Social Login Section
                        VStack(spacing: 16) {
                            HStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 1)
                                
                                Text("Log in with")
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 12)
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 1)
                            }
                            .padding(.horizontal, 24)
                            
                            HStack(spacing: 24) {
                                SocialLoginButton(icon: "apple.logo", color: .black)
                                SocialLoginButton(icon: "globe", color: Color(red: 0.26, green: 0.52, blue: 0.96))
                                SocialLoginButton(icon: "f.circle.fill", color: Color(red: 0.23, green: 0.35, blue: 0.60))
                            }
                            .padding(.horizontal, 24)
                        }
                        .padding(.top, 32)
                        
                        // Sign Up Link
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(.secondary)
                            
                            Button(action: {
                                showSignup = true
                            }) {
                                Text("Sign Up")
                                    .foregroundColor(AppTheme.primaryOrange)
                                    .fontWeight(.semibold)
                            }
                        }
                        .padding(.top, 24)
                        .padding(.bottom, 40)
                    }
                }
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
            .sheet(isPresented: $showForgotPassword) {
                ForgotPasswordView()
            }
            .sheet(isPresented: $showSignup) {
                // Navigate to signup - this would be handled by onboarding state
                Text("Sign Up")
            }
        }
    }
}

struct SocialLoginButton: View {
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: {
            // Handle social login
        }) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)
                .frame(width: 60, height: 60)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

struct BackgroundCloudView: View {
    var body: some View {
        ZStack {
            Color(red: 0.98, green: 0.98, blue: 1.0)
            
            // Cloud-like shapes
            Circle()
                .fill(Color.white.opacity(0.6))
                .frame(width: 200, height: 200)
                .offset(x: -100, y: -200)
            
            Circle()
                .fill(Color.white.opacity(0.5))
                .frame(width: 150, height: 150)
                .offset(x: 150, y: -150)
            
            Circle()
                .fill(Color.white.opacity(0.4))
                .frame(width: 180, height: 180)
                .offset(x: -80, y: 300)
        }
    }
}

