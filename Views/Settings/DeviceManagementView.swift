//
//  DeviceManagementView.swift
//  BabyGuardian
//
//  Device management screen with connected devices
//

import SwiftUI

struct DeviceManagementView: View {
    @State private var showAddDevice = false
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Connected Devices Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Connected Devices")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        
                        DeviceCard(
                            icon: "applewatch",
                            name: "Baby Wearable-Amira",
                            status: "Connected",
                            lastSync: "3 min ago",
                            version: "v3.1.0",
                            details: nil
                        )
                    }
                    
                    // Camera Monitor Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Camera Monitor")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        CameraDeviceCard(
                            name: "CCTV-12 Camera",
                            status: "Connected",
                            features: "Heart rate, temperature, Smoke",
                            thumbnail: "baby_thumbnail"
                        )
                    }
                    
                    // Sensors Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Sensors")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        SensorDeviceCard(
                            name: "DHT11 Sensor",
                            status: "Connected",
                            activeSensors: "Temperature, Humidity",
                            lastSync: "3 days ago"
                        )
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("My Devices")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showAddDevice = true
                }) {
                    Text("Add Device")
                        .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                }
            }
        }
        .sheet(isPresented: $showAddDevice) {
            AddDeviceView()
        }
    }
}

struct DeviceCard: View {
    let icon: String
    let name: String
    let status: String
    let lastSync: String
    let version: String
    let details: String?
    
    var body: some View {
        HStack(spacing: 16) {
            // Device Icon
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(.blue)
            }
            
            // Device Info
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.system(size: 18, weight: .semibold))
                
                HStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 8, height: 8)
                        Text(status)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    
                    Text("•")
                        .foregroundColor(.secondary)
                    
                    Text("Last sync \(lastSync)")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                if let details = details {
                    Text(details)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                
                Text("Version \(version)")
                    .font(.system(size: 12))
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .padding(.horizontal, 20)
    }
}

struct CameraDeviceCard: View {
    let name: String
    let status: String
    let features: String
    let thumbnail: String
    
    var body: some View {
        HStack(spacing: 16) {
            // Camera Icon with Thumbnail
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black)
                    .frame(width: 80, height: 60)
                    .overlay(
                        Image(systemName: "video.fill")
                            .foregroundColor(.white.opacity(0.7))
                    )
                
                // Thumbnail overlay
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "camera.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .padding(4)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(4)
                    }
                    .padding(4)
                }
            }
            
            // Camera Info
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.system(size: 18, weight: .semibold))
                
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                    Text(status)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Text(features)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .padding(.horizontal, 20)
    }
}

struct SensorDeviceCard: View {
    let name: String
    let status: String
    let activeSensors: String
    let lastSync: String
    
    var body: some View {
        HStack(spacing: 16) {
            // Sensor Icon
            ZStack {
                Circle()
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: "sensor.tag.radiowaves.forward.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.purple)
            }
            
            // Sensor Info
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.system(size: 18, weight: .semibold))
                
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                    Text(status)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Text("Active sensors: \(activeSensors)")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                
                Text("Last sync \(lastSync)")
                    .font(.system(size: 12))
                    .foregroundColor(.orange)
            }
            
            Spacer()
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .padding(.horizontal, 20)
    }
}

struct AddDeviceView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Add Device")
                    .font(.title)
                    .padding()
                // TODO: Implement add device functionality
            }
            .navigationTitle("Add Device")
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

