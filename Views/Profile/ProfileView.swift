//
//  ProfileView.swift
//  BabyGuardian
//
//  User profile screen with baby profiles and quick actions
//

import SwiftUI

struct ProfileView: View {
    @State private var showEdit = false
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // User Profile Section
                    VStack(spacing: 16) {
                        // Profile Picture
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Text("AD")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(.blue)
                            )
                        
                        // User Info
                        VStack(spacing: 8) {
                            Text("Anne Doe")
                                .font(.system(size: 24, weight: .bold))
                            
                            Text("annedoe@gmail.com")
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                            
                            Text("+250 781 834 409")
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                            
                            Text("Mother")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color(red: 1.0, green: 0.6, blue: 0.0).opacity(0.2))
                                .cornerRadius(8)
                        }
                        
                        // Edit Button
                        Button(action: {
                            showEdit = true
                        }) {
                            Text("Edit")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 100)
                                .padding(.vertical, 10)
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
                                .cornerRadius(12)
                        }
                    }
                    .padding(24)
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Baby Profiles Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Baby Profiles")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        HStack(spacing: 16) {
                            // Baby Profile Card
                            VStack(alignment: .leading, spacing: 12) {
                                HStack(spacing: 12) {
                                    Circle()
                                        .fill(Color.pink.opacity(0.3))
                                        .frame(width: 60, height: 60)
                                        .overlay(
                                            Text("A")
                                                .font(.system(size: 24, weight: .bold))
                                                .foregroundColor(.pink)
                                        )
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Amira")
                                            .font(.system(size: 18, weight: .semibold))
                                        
                                        Text("6 months")
                                            .font(.system(size: 14))
                                            .foregroundColor(.secondary)
                                        
                                        Text("Normal Temp-35.8 C HR 92")
                                            .font(.system(size: 12))
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                Button(action: {}) {
                                    Text("View Health Data")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                                }
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            
                            // Add Baby Button
                            Button(action: {}) {
                                VStack(spacing: 8) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 24))
                                        .foregroundColor(.secondary)
                                    
                                    Text("Add another baby")
                                        .font(.system(size: 12))
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 140)
                                .background(Color(.systemBackground))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                        .foregroundColor(.gray.opacity(0.3))
                                )
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 8)
                    
                    // Quick Actions Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quick Actions")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        HStack(spacing: 16) {
                            QuickActionButton(
                                icon: "heart.fill",
                                title: "View Health Stats",
                                color: .red
                            )
                            
                            QuickActionButton(
                                icon: "video.fill",
                                title: "Camera Monitoring",
                                color: .blue
                            )
                            
                            QuickActionButton(
                                icon: "gearshape.fill",
                                title: "Manage Devices",
                                color: .gray
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 8)
                    
                    // Security & Privacy Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Security & Privacy")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            SettingsRow(
                                title: "Change Password",
                                icon: "lock.fill"
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            SettingsRow(
                                title: "Linked Family Accounts",
                                icon: "person.2.fill"
                            )
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showEdit = true
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.primary)
                }
            }
        }
        .sheet(isPresented: $showEdit) {
            EditProfileView()
        }
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(color)
                
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color(.systemBackground))
            .cornerRadius(12)
        }
    }
}

struct SettingsRow: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.secondary)
                .frame(width: 24)
            
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Edit Profile")
                    .font(.title)
                    .padding()
                // TODO: Implement edit profile form
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

