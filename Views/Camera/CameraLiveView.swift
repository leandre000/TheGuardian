//
//  CameraLiveView.swift
//  BabyGuardian
//
//  Live camera view with video feed and vital stats overlays
//

import SwiftUI

struct CameraLiveView: View {
    let roomName: String
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    @State private var isPlaying = true
    @State private var currentTime = "07:20:31"
    @State private var currentSong = "Twinkle Twinkle little star"
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "person.fill")
                                .foregroundColor(.white)
                        )
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                // Video Feed
                ZStack {
                    // Video placeholder
                    Rectangle()
                        .fill(Color.black)
                        .overlay(
                            VStack {
                                Image(systemName: "video.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.white.opacity(0.5))
                                
                                Text("Live Stream")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white.opacity(0.7))
                                    .padding(.top, 12)
                            }
                        )
                    
                    // Song and timer overlay
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(currentSong)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                
                                Text(currentTime)
                                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(10)
                            
                            Spacer()
                            
                            Button(action: {
                                isPlaying.toggle()
                            }) {
                                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(20)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        Spacer()
                    }
                    
                    // Vital Stats Overlays
                    VStack {
                        HStack {
                            Spacer()
                            
                            VitalStatOverlay(
                                icon: "thermometer",
                                value: "\(Int(healthMonitor.currentMetrics?.temperature ?? 32))°C",
                                label: "Body Temperature"
                            )
                        }
                        .padding(.top, 60)
                        .padding(.trailing, 20)
                        
                        Spacer()
                        
                        HStack {
                            VitalStatOverlay(
                                icon: "heart.fill",
                                value: "\(healthMonitor.currentMetrics?.heartRate ?? 32) BPM",
                                label: "Heart Rate"
                            )
                            
                            Spacer()
                        }
                        .padding(.leading, 20)
                        .padding(.bottom, 100)
                        
                        HStack {
                            Spacer()
                            
                            VitalStatOverlay(
                                icon: "lungs.fill",
                                value: "\(Int(healthMonitor.currentMetrics?.oxygenSaturation ?? 95))%",
                                label: "Oxygen"
                            )
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
                
                // Bottom Controls
                HStack(spacing: 30) {
                    ControlButton(icon: "square.grid.2x2", action: {})
                    ControlButton(icon: "bell.fill", action: {})
                    ControlButton(icon: "waveform", action: {})
                    ControlButton(icon: "mic.fill", action: {})
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .background(Color.black.opacity(0.8))
            }
        }
        .navigationBarHidden(true)
    }
}

struct VitalStatOverlay: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.white)
            
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(16)
        .background(Color.black.opacity(0.6))
        .cornerRadius(16)
    }
}

struct ControlButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
        }
    }
}

