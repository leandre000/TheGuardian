//
//  AIInsightsView.swift
//  BabyGuardian
//
//  AI Insights screen with wellness score and predictions
//

import SwiftUI

struct AIInsightsView: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Description
                    Text("Your baby's wellness patterns and predictions at a glance.")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    
                    // Amira's Summary Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Amira's Summary")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        HStack(spacing: 20) {
                            // Wellness Score Circle
                            ZStack {
                                Circle()
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 12)
                                    .frame(width: 120, height: 120)
                                
                                Circle()
                                    .trim(from: 0, to: 0.92)
                                    .stroke(
                                        AppTheme.blueGradient,
                                        style: StrokeStyle(lineWidth: 12, lineCap: .round)
                                    )
                                    .frame(width: 120, height: 120)
                                    .rotationEffect(.degrees(-90))
                                
                                VStack {
                                    Text("92%")
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundColor(.primary)
                                }
                            }
                            
                            // Vital Signs List
                            VStack(alignment: .leading, spacing: 12) {
                                VitalSignRow(label: "Oxygen level", value: "\(Int(healthMonitor.currentMetrics?.oxygenSaturation ?? 98))%")
                                VitalSignRow(label: "Heart Rate", value: "\(healthMonitor.currentMetrics?.heartRate ?? 122) bpm")
                                VitalSignRow(label: "Body Temp.", value: String(format: "%.1f C", healthMonitor.currentMetrics?.temperature ?? 36.8))
                                VitalSignRow(label: "Sleep Quality", value: "8.5/10")
                            }
                            
                            Spacer()
                        }
                        .padding(20)
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .padding(.horizontal, 20)
                        
                        // Status Message
                        Text("All readings stable. No anomalies detected.")
                            .font(.system(size: 14))
                            .foregroundColor(.green)
                            .padding(.horizontal, 20)
                    }
                    
                    // Trends & Predictions Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Trends & Predictions")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        HStack(spacing: 16) {
                            TrendCard(
                                title: "Sleep Patterns",
                                description: "Baby's sleep increased by 15% this week"
                            )
                            
                            TrendCard(
                                title: "Sleep Patterns",
                                description: "Baby's sleep increased by 15% this week"
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // AI Predictions Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("AI Predictions")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        HStack(spacing: 16) {
                            PredictionCard(
                                icon: "babybottle.fill",
                                title: "Next Feeding Time",
                                value: "Expected at 2:30 PM",
                                color: .blue
                            )
                            
                            PredictionCard(
                                icon: "bed.double.fill",
                                title: "Optimal Nap Window",
                                value: "Between 4:00 PM - 5:30 PM",
                                color: .purple
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("AI Insights")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "clock")
                            .foregroundColor(AppTheme.primaryOrange)
                    }
            }
        }
    }
}

struct VitalSignRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
        }
    }
}

struct TrendCard: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Graph placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.red.opacity(0.1))
                    .frame(height: 80)
                
                // Simple wave graph
                Path { path in
                    let width: CGFloat = 100
                    let height: CGFloat = 60
                    let centerY = height / 2
                    
                    path.move(to: CGPoint(x: 0, y: centerY))
                    
                    for i in 0..<10 {
                        let x = CGFloat(i) * (width / 10)
                        let y = centerY + sin(CGFloat(i) * 0.5) * 20
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
                .stroke(Color.red, lineWidth: 2)
            }
            
            Text(title)
                .font(.system(size: 16, weight: .semibold))
            
            Text(description)
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

struct PredictionCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundColor(color)
            
            Text(title)
                .font(.system(size: 16, weight: .semibold))
            
            Text(value)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }
}

