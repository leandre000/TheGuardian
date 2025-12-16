//
//  EmailSentView.swift
//  BabyGuardian
//
//  Email sent confirmation screen
//

import SwiftUI

struct EmailSentView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundCloudView()
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // Checkmark Icon
                    ZStack {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 120, height: 120)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 20)
                    
                    // Title
                    Text("Email has been sent!")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                    
                    // Instructions
                    Text("Please check your inbox and click in the received link to reset your password")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    
                    // Finish Button
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Finish")
                            .primaryButton()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

