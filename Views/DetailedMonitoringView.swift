//
//  DetailedMonitoringView.swift
//  BabyGuardian
//
//  Detailed monitoring view with heart visualization and tabs
//

import SwiftUI

struct DetailedMonitoringView: View {
    @State private var selectedTab: MonitoringTab = .heartRate
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    
    enum MonitoringTab: String, CaseIterable {
        case heartRate = "Heart Rate"
        case sleep = "Sleep"
        case health = "Health"
        case other = "Other"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header with profile
                    HStack {
                        HStack(spacing: 12) {
                            Circle()
                                .fill(Color.blue.opacity(0.3))
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Text("J")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.blue)
                                )
                            
                            Text("Jesper")
                                .font(.system(size: 18, weight: .semibold))
                            
                            Image(systemName: "chevron.down")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .foregroundColor(.secondary)
                            )
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color(.systemBackground))
                    
                    // Title
                    HStack {
                        Text("Baby Monitoring")
                            .font(.system(size: 28, weight: .bold))
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    .background(Color(.systemBackground))
                    
                    // Tabs
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 24) {
                            ForEach(MonitoringTab.allCases, id: \.self) { tab in
                                TabButton(
                                    title: tab.rawValue,
                                    isSelected: selectedTab == tab
                                ) {
                                    withAnimation {
                                        selectedTab = tab
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20)
                    .background(Color(.systemBackground))
                    
                    // Content based on selected tab
                    ScrollView {
                        VStack(spacing: 24) {
                            if selectedTab == .heartRate {
                                HeartRateDetailView()
                            } else if selectedTab == .sleep {
                                SleepDetailView()
                            } else if selectedTab == .health {
                                HealthDetailView()
                            } else {
                                OtherDetailView()
                            }
                        }
                        .padding(.top, 20)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? Color(red: 0.2, green: 0.5, blue: 0.9) : .secondary)
                
                Rectangle()
                    .fill(isSelected ? Color(red: 0.2, green: 0.5, blue: 0.9) : Color.clear)
                    .frame(height: 3)
            }
        }
    }
}

struct HeartRateDetailView: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    
    var body: some View {
        VStack(spacing: 32) {
            // Heart Visualization
            ZStack {
                // 3D Heart representation
                HeartShape()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.red.opacity(0.8),
                                Color.pink.opacity(0.6)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 200, height: 200)
                    .shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 10)
            }
            .padding(.top, 20)
            
            // Heart Metrics
            VStack(spacing: 20) {
                MetricRow(
                    label: "Heart Rate",
                    value: "\(healthMonitor.currentMetrics?.heartRate ?? 21) BPM"
                )
                
                MetricRow(
                    label: "Heart Status",
                    value: "Good",
                    valueColor: .green
                )
                
                MetricRow(
                    label: "Daily Avg",
                    value: "\(Int(healthMonitor.getAverageHeartRate())) BPM"
                )
            }
            .padding(.horizontal, 20)
            
            // Recommendations
            VStack(alignment: .leading, spacing: 16) {
                Text("Recommendations")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.horizontal, 20)
                
                RecommendationRow(
                    text: "Your baby's heart is healthy. Continue monitoring regularly"
                )
                
                RecommendationRow(
                    text: "Keep your baby calm and ensure good hydration."
                )
            }
            .padding(.top, 20)
        }
    }
}

struct HeartShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Simplified heart shape
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width / 2, y: height * 0.7))
        
        // Left curve
        path.addCurve(
            to: CGPoint(x: width * 0.2, y: height * 0.3),
            control1: CGPoint(x: width * 0.1, y: height * 0.6),
            control2: CGPoint(x: width * 0.1, y: height * 0.4)
        )
        
        // Top left
        path.addCurve(
            to: CGPoint(x: width / 2, y: height * 0.1),
            control1: CGPoint(x: width * 0.3, y: height * 0.2),
            control2: CGPoint(x: width * 0.4, y: height * 0.1)
        )
        
        // Top right
        path.addCurve(
            to: CGPoint(x: width * 0.8, y: height * 0.3),
            control1: CGPoint(x: width * 0.6, y: height * 0.1),
            control2: CGPoint(x: width * 0.7, y: height * 0.2)
        )
        
        // Right curve
        path.addCurve(
            to: CGPoint(x: width / 2, y: height * 0.7),
            control1: CGPoint(x: width * 0.9, y: height * 0.4),
            control2: CGPoint(x: width * 0.9, y: height * 0.6)
        )
        
        path.closeSubpath()
        
        return path
    }
}

struct MetricRow: View {
    let label: String
    let value: String
    var valueColor: Color = .primary
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(valueColor)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

struct RecommendationRow: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(Color(red: 0.2, green: 0.5, blue: 0.9))
                .frame(width: 8, height: 8)
                .padding(.top, 6)
            
            Text(text)
                .font(.system(size: 15))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct SleepDetailView: View {
    var body: some View {
        VStack {
            Text("Sleep Details")
                .font(.title)
                .padding()
        }
    }
}

struct HealthDetailView: View {
    var body: some View {
        VStack {
            Text("Health Details")
                .font(.title)
                .padding()
        }
    }
}

struct OtherDetailView: View {
    var body: some View {
        VStack {
            Text("Other Details")
                .font(.title)
                .padding()
        }
    }
}

