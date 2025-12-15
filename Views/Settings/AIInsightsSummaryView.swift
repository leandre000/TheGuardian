//
//  AIInsightsSummaryView.swift
//  BabyGuardian
//
//  AI insights summary with trends and predictions
//

import SwiftUI

struct AIInsightsSummaryView: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("AI Insights")
                            .font(.system(size: 22, weight: .bold))
                        Text("Your baby's wellness patterns and predictions at a glance")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    // Summary donut
                    SummaryDonutCard()
                    
                    // Trends & Predictions
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Trends & Predictions")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        HStack(spacing: 16) {
                            TrendCard(title: "Sleep Patterns", detail: "Baby's sleep increased by 15% this week.")
                            TrendCard(title: "Sleep Patterns", detail: "Baby's sleep increased by 15% this week.")
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // AI Predictions
                    VStack(alignment: .leading, spacing: 16) {
                        Text("AI Predictions")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.horizontal, 20)
                        
                        HStack(spacing: 16) {
                            PredictionCard(
                                icon: "drop.fill",
                                title: "Next Feeding Time",
                                subtitle: "Expected at 2:30 PM",
                                color: Color(red: 0.2, green: 0.5, blue: 0.9)
                            )
                            
                            PredictionCard(
                                icon: "moon.zzz.fill",
                                title: "Optimal Nap Window",
                                subtitle: "Between 4:00 PM - 5:30 PM",
                                color: Color(red: 0.6, green: 0.3, blue: 0.9)
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)
                    }
                }
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("AI Insights")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SummaryDonutCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Amira’s Summary")
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal, 20)
                .padding(.top, 16)
            
            HStack(alignment: .center, spacing: 20) {
                DonutChart(value: 0.92, label: "Wellness")
                    .frame(width: 140, height: 140)
                
                VStack(alignment: .leading, spacing: 8) {
                    SummaryRow(label: "Oxygen level", value: "98%")
                    SummaryRow(label: "Heart Rate", value: "82 bpm")
                    SummaryRow(label: "Body Temp.", value: "36.8 C")
                    SummaryRow(label: "Sleep Quality", value: "8.5/10")
                }
                .padding(.trailing, 16)
            }
            
            Text("All readings stable. No anomalies detected.")
                .font(.system(size: 14))
                .foregroundColor(.green)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 20)
    }
}

struct DonutChart: View {
    let value: CGFloat
    let label: String
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.gray.opacity(0.2), lineWidth: 12)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .trim(from: 0, to: value)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.red, Color.orange]),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            
            VStack(spacing: 6) {
                Text("\(Int(value * 100))%")
                    .font(.system(size: 24, weight: .bold))
                Text(label)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct SummaryRow: View {
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
    let detail: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Placeholder for graph
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.red.opacity(0.2), Color.orange.opacity(0.3)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 90)
                .overlay(
                    Image(systemName: "waveform.path.ecg")
                        .font(.system(size: 28))
                        .foregroundColor(Color.red.opacity(0.5))
                )
            
            Text(title)
                .font(.system(size: 15, weight: .semibold))
            
            Text(detail)
                .font(.system(size: 13))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
    }
}

struct PredictionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 26))
                .foregroundColor(color)
            
            Text(title)
                .font(.system(size: 15, weight: .semibold))
            
            Text(subtitle)
                .font(.system(size: 13))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
    }
}


