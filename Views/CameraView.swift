//
//  CameraView.swift
//  BabyGuardian
//
//  Live camera monitoring view
//

import SwiftUI

struct CameraView: View {
    @EnvironmentObject var cryDetection: CryDetectionService
    @EnvironmentObject var alertManager: AlertManager
    @State private var isStreaming = false
    @State private var showSettings = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Camera Feed Placeholder
                CameraFeedView(isStreaming: $isStreaming)
                
                // Overlay Controls
                VStack {
                    Spacer()
                    
                    CameraControlsView(
                        isStreaming: $isStreaming,
                        showSettings: $showSettings
                    )
                }
                
                // Cry Detection Indicator
                if cryDetection.isCrying {
                    CryDetectionOverlay()
                }
            }
            .navigationTitle("Live Camera")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showSettings.toggle() }) {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                CameraSettingsView()
            }
        }
    }
}

struct CameraFeedView: View {
    @Binding var isStreaming: Bool
    
    var body: some View {
        ZStack {
            // Placeholder for camera feed
            Rectangle()
                .fill(Color.black)
                .overlay(
                    VStack(spacing: 20) {
                        Image(systemName: isStreaming ? "video.fill" : "video.slash.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white.opacity(0.7))
                        
                        Text(isStreaming ? "Live Stream Active" : "Stream Not Active")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.headline)
                        
                        if !isStreaming {
                            Text("Tap play to start streaming")
                                .foregroundColor(.white.opacity(0.5))
                                .font(.caption)
                        }
                    }
                )
            
            // Simulated video feed (in production, this would be actual video stream)
            if isStreaming {
                // Placeholder for actual video player
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct CameraControlsView: View {
    @Binding var isStreaming: Bool
    @Binding var showSettings: Bool
    
    var body: some View {
        HStack(spacing: 30) {
            // Record Button
            Button(action: {}) {
                Image(systemName: "record.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.red)
            }
            
            // Play/Pause Button
            Button(action: {
                isStreaming.toggle()
            }) {
                Image(systemName: isStreaming ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
            }
            
            // Snapshot Button
            Button(action: {}) {
                Image(systemName: "camera.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.black.opacity(0.5))
        .cornerRadius(30)
        .padding(.bottom, 30)
    }
}

struct CryDetectionOverlay: View {
    @EnvironmentObject var cryDetection: CryDetectionService
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.title)
                        .foregroundColor(.orange)
                    
                    Text("Cry Detected")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("Comfort system active")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    
                    // Intensity Indicator
                    HStack(spacing: 4) {
                        ForEach(0..<5) { index in
                            Circle()
                                .fill(index < Int(cryDetection.cryIntensity * 5) ? Color.orange : Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                        }
                    }
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(12)
                .padding()
            }
            Spacer()
        }
    }
}

struct CameraSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var videoQuality = "HD"
    @State private var enableAudio = true
    @State private var enableNightVision = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("Video Settings") {
                    Picker("Quality", selection: $videoQuality) {
                        Text("SD").tag("SD")
                        Text("HD").tag("HD")
                        Text("Full HD").tag("Full HD")
                    }
                    
                    Toggle("Enable Audio", isOn: $enableAudio)
                    Toggle("Night Vision", isOn: $enableNightVision)
                }
                
                Section("Recording") {
                    Toggle("Auto Record", isOn: .constant(false))
                    Picker("Record Duration", selection: .constant("1 hour")) {
                        Text("30 minutes").tag("30 minutes")
                        Text("1 hour").tag("1 hour")
                        Text("2 hours").tag("2 hours")
                    }
                }
            }
            .navigationTitle("Camera Settings")
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

