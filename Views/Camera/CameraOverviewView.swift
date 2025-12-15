//
//  CameraOverviewView.swift
//  BabyGuardian
//
//  Camera overview screen showing all available cameras
//

import SwiftUI

struct CameraOverviewView: View {
    @State private var showAddCamera = false
    @State private var showSettings = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        HStack {
                            Text("Your Cameras")
                                .font(.system(size: 32, weight: .bold))
                            
                            Spacer()
                            
                            HStack(spacing: 20) {
                                Button(action: {
                                    showSettings = true
                                }) {
                                    Image(systemName: "gearshape.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.primary)
                                }
                                
                                Button(action: {
                                    showAddCamera = true
                                }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        // Camera Cards
                        VStack(spacing: 16) {
                            CameraPreviewCard(
                                roomName: "Jesper's room",
                                batteryLevel: 77,
                                imageName: "baby1"
                            )
                            
                            CameraPreviewCard(
                                roomName: "Teta's room",
                                batteryLevel: 83,
                                imageName: "baby2"
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showSettings) {
                CameraSettingsView()
            }
            .sheet(isPresented: $showAddCamera) {
                AddCameraView()
            }
        }
    }
}

struct CameraPreviewCard: View {
    let roomName: String
    let batteryLevel: Int
    let imageName: String
    @State private var showLiveView = false
    
    var body: some View {
        Button(action: {
            showLiveView = true
        }) {
            ZStack {
                // Camera preview placeholder
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.black)
                    .frame(height: 200)
                    .overlay(
                        VStack {
                            Image(systemName: "video.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white.opacity(0.7))
                            
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.white.opacity(0.8))
                                .padding(.top, 8)
                        }
                    )
                
                // Overlay elements
                VStack {
                    HStack {
                        Image(systemName: "video.fill")
                            .foregroundColor(.white.opacity(0.8))
                            .padding(8)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(8)
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "battery.100")
                                .foregroundColor(.white)
                            Text("\(batteryLevel)%")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                    }
                    .padding(12)
                    
                    Spacer()
                    
                    HStack {
                        Text(roomName)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(8)
                        
                        Spacer()
                    }
                    .padding(12)
                }
            }
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        }
        .fullScreenCover(isPresented: $showLiveView) {
            CameraLiveView(roomName: roomName)
        }
    }
}

struct AddCameraView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Add Camera")
                    .font(.title)
                    .padding()
                // TODO: Implement add camera functionality
            }
            .navigationTitle("Add Camera")
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

