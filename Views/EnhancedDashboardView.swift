//
//  EnhancedDashboardView.swift
//  BabyGuardian
//
//  Enhanced dashboard with live video feed and metrics
//

import SwiftUI

struct EnhancedDashboardView: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    @EnvironmentObject var sensorService: SensorService
    @State private var showFullStream = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Live Video Feed Section
                        VStack(spacing: 0) {
                            ZStack {
                                // Video placeholder
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(height: 300)
                                    .overlay(
                                        VStack {
                                            Image(systemName: "video.fill")
                                                .font(.system(size: 40))
                                                .foregroundColor(.white.opacity(0.7))
                                            
                                            Text("Tap to view full stream")
                                                .font(.system(size: 14))
                                                .foregroundColor(.white.opacity(0.7))
                                                .padding(.top, 8)
                                        }
                                    )
                                
                                // Live indicator
                                VStack {
                                    HStack {
                                        HStack(spacing: 6) {
                                            Circle()
                                                .fill(Color.red)
                                                .frame(width: 8, height: 8)
                                            Text("Live")
                                                .font(.system(size: 12, weight: .semibold))
                                                .foregroundColor(.white)
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.black.opacity(0.5))
                                        .cornerRadius(20)
                                        
                                        Spacer()
                                        
                                        // Notification icons
                                        HStack(spacing: 12) {
                                            Image(systemName: "bell.fill")
                                                .foregroundColor(.white)
                                            Image(systemName: "gearshape.fill")
                                                .foregroundColor(.white)
                                        }
                                        .padding(.trailing, 16)
                                    }
                                    .padding(.top, 16)
                                    
                                    Spacer()
                                }
                            }
                            .onTapGesture {
                                showFullStream = true
                            }
                            
                            // Metrics Cards Row
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    MetricCard(
                                        icon: "heart.fill",
                                        value: "\(healthMonitor.currentMetrics?.heartRate ?? 71)",
                                        unit: "bpm",
                                        color: Color(red: 1.0, green: 0.6, blue: 0.0),
                                        showGraph: true
                                    )
                                    
                                    MetricCard(
                                        icon: "moon.fill",
                                        value: "\(healthMonitor.currentMetrics?.heartRate ?? 71)",
                                        unit: "bpm",
                                        color: .blue,
                                        showGraph: false
                                    )
                                    
                                    MetricCard(
                                        icon: "thermometer",
                                        value: "\(Int(sensorService.currentSensorData?.roomTemperature ?? 27))",
                                        unit: "°C",
                                        color: .orange,
                                        showGraph: false
                                    )
                                    
                                    MetricCard(
                                        icon: "wind",
                                        value: "97",
                                        unit: "%",
                                        color: .green,
                                        showGraph: false
                                    )
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                            }
                        }
                        .background(Color(.systemBackground))
                        
                        // Actions Section
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Actions")
                                    .font(.system(size: 20, weight: .bold))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            
                            ActionRow(text: "See what your baby is up to...")
                            ActionRow(text: "Navigate our app's new features...")
                            ActionRow(text: "Change your settings to better fit...")
                            ActionRow(text: "Read on the new regulations about...")
                        }
                        .background(Color(.systemBackground))
                        .padding(.top, 8)
                        
                        // AI Insights Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("AI Insights")
                                .font(.system(size: 20, weight: .bold))
                                .padding(.horizontal, 20)
                                .padding(.top, 20)
                            
                            HStack(spacing: 16) {
                                InsightCard(
                                    title: "Sleep Time",
                                    value: "9 hrs",
                                    subtitle: "Min. sleep hours",
                                    color: .blue
                                )
                                
                                InsightCard(
                                    title: "Temperature",
                                    value: "29°C",
                                    subtitle: "Optimal Temp.",
                                    color: .orange
                                )
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                        }
                        .background(Color(.systemBackground))
                        .padding(.top, 8)
                    }
                }
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.large)
            .fullScreenCover(isPresented: $showFullStream) {
                CameraView()
            }
        }
    }
}

struct MetricCard: View {
    let icon: String
    let value: String
    let unit: String
    let color: Color
    let showGraph: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 24))
                
                Spacer()
            }
            
            if showGraph {
                // Simple bar graph
                HStack(alignment: .bottom, spacing: 4) {
                    ForEach(0..<5) { index in
                        Rectangle()
                            .fill(color.opacity(0.6))
                            .frame(width: 8, height: CGFloat.random(in: 20...40))
                    }
                }
                .frame(height: 40)
            }
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(value)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
                
                Text(unit)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
        }
        .padding(16)
        .frame(width: 140, height: 140)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

struct ActionRow: View {
    let text: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Text(text)
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.system(size: 12))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct InsightCard: View {
    let title: String
    let value: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(color)
            
            Text(subtitle)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.systemGroupedBackground))
        .cornerRadius(16)
    }
}

