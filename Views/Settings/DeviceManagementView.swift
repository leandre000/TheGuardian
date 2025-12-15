//
//  DeviceManagementView.swift
//  BabyGuardian
//
//  Device management screen with connected devices and sensors
//

import SwiftUI

struct DeviceManagementView: View {
    @State private var showAddDevice = false
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    HStack {
                        Text("My Devices")
                            .font(.system(size: 28, weight: .bold))
                        
                        Spacer()
                        
                        Button(action: {
                            showAddDevice = true
                        }) {
                            Text("Add Device")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
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
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    // Connected Devices
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Connected Devices")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        DeviceCard(
                            title: "Baby Wearable-Amira",
                            status: "Connected",
                            statusColor: .green,
                            lastSync: "2 min ago",
                            firmware: "v2.0.0",
                            metrics: "Heart rate, Temperature, SpO2"
                        )
                        
                        DeviceCard(
                            title: "CCTV-12 Camera",
                            status: "Connected",
                            statusColor: .green,
                            lastSync: "just now",
                            firmware: "v1.6.2",
                            metrics: "Heart rate, Temperature, Smoke"
                        )
                    }
                    
                    // Sensors
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Sensors")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        DeviceCard(
                            title: "DHT11 Sensor",
                            status: "Connected",
                            statusColor: .green,
                            lastSync: "3 days ago",
                            firmware: "v1.0.0",
                            metrics: "Temperature, Humidity"
                        )
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("Device Management")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showAddDevice) {
            AddDeviceSheet()
        }
    }
}

struct DeviceCard: View {
    let title: String
    let status: String
    let statusColor: Color
    let lastSync: String
    let firmware: String
    let metrics: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.9, green: 0.95, blue: 1.0))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(systemName: "app.connected.to.app.below.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.9))
                    )
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 8) {
                        Circle()
                            .fill(statusColor)
                            .frame(width: 8, height: 8)
                        Text(status)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(statusColor)
                        Text("• Last sync: \(lastSync)")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        Text(firmware)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .foregroundColor(.secondary)
            }
            
            Divider()
                .padding(.leading, 60)
            
            HStack(spacing: 8) {
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(.secondary)
                Text(metrics)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 4)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 20)
    }
}

struct AddDeviceSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Add a new device by scanning or entering the device code.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: {}) {
                    Text("Scan QR Code")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                }
                
                Button(action: {}) {
                    Text("Enter Device Code")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
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


