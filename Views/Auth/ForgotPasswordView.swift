//
//  ForgotPasswordView.swift
//  BabyGuardian
//
//  Forgot password screen with email input
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email: String = "laetitia221@gmail.com"
    @State private var showEmailSent = false
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundCloudView()
                    .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    Spacer()
                    
                    VStack(spacing: 24) {
                        // Title
                        Text("Forgot your password?")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        // Instructions
                        Text("Enter your registered email below to receive password reset instruction")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                        
                        // Email Field
                        CustomTextField(
                            title: "Email",
                            text: $email,
                            placeholder: "Enter your email",
                            icon: "envelope.fill",
                            keyboardType: .emailAddress
                        )
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        
                        // Send Button
                        Button(action: {
                            showEmailSent = true
                        }) {
                            Text("Send")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
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
                                .cornerRadius(14)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                }
            }
            .fullScreenCover(isPresented: $showEmailSent) {
                EmailSentView()
            }
        }
    }
}

