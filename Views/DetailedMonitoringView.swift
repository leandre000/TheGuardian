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
                    .foregroundColor(isSelected ? AppTheme.primaryBlue : .secondary)
                
                Rectangle()
                    .fill(isSelected ? AppTheme.primaryBlue : Color.clear)
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
                .fill(AppTheme.primaryBlue)
                .frame(width: 8, height: 8)
                .padding(.top, 6)
            
            Text(text)
                .font(.system(size: 15))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

struct SleepDetailView: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    @State private var cycle1Enabled = true
    @State private var cycle2Enabled = true
    
    var body: some View {
        VStack(spacing: 24) {
            // Sleep Illustration
            ZStack {
                // Baby sleeping illustration placeholder
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue.opacity(0.1),
                                Color.blue.opacity(0.05)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 200)
                    .overlay(
                        VStack {
                            Image(systemName: "bed.double.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.blue.opacity(0.6))
                            
                            Text("12:20:51")
                                .font(.system(size: 24, weight: .bold, design: .monospaced))
                                .foregroundColor(.primary)
                                .padding(.top, 12)
                        }
                    )
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            // Sleep Time Message
            VStack(alignment: .leading, spacing: 12) {
                Text("Sleep time")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text("Sweet dreams! Your little one is peacefully asleep. Baby had a calm and healthy sleep. No issues detected.")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .padding(.horizontal, 20)
            
            // Vital Signs Cards
            HStack(spacing: 12) {
                VitalSignCard(
                    icon: "heart.fill",
                    label: "Heart Rate",
                    value: "\(healthMonitor.currentMetrics?.heartRate ?? 21) BPM",
                    color: .red
                )
                
                VitalSignCard(
                    icon: "lungs.fill",
                    label: "Oxygen",
                    value: "\(Int(healthMonitor.currentMetrics?.oxygenSaturation ?? 21))%",
                    color: .blue
                )
                
                VitalSignCard(
                    icon: "thermometer",
                    label: "Body Temp",
                    value: "\(Int(healthMonitor.currentMetrics?.temperature ?? 36))°C",
                    color: .orange
                )
            }
            .padding(.horizontal, 20)
            
            // Sleep Cycles Section
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Sleep Cycles")
                        .font(.system(size: 18, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.0))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                SleepCycleRow(
                    title: "Cycle 1 (07:00-11:00 Everyday)",
                    isEnabled: $cycle1Enabled
                )
                
                SleepCycleRow(
                    title: "Cycle 2 (18:00-23:00)",
                    isEnabled: $cycle2Enabled
                )
            }
            .background(Color(red: 1.0, green: 0.95, blue: 0.9))
            .cornerRadius(16)
            .padding(.horizontal, 20)
            .padding(.top, 8)
        }
    }
}

struct VitalSignCard: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)
            
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

struct SleepCycleRow: View {
    let title: String
    @Binding var isEnabled: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 15))
                .foregroundColor(.primary)
            
            Spacer()
            
            Toggle("", isOn: $isEnabled)
                .labelsHidden()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

struct HealthDetailView: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    @State private var feedingTime1Enabled = true
    @State private var feedingTime2Enabled = true
    
    var body: some View {
        VStack(spacing: 24) {
            // Oxygen Sphere
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue.opacity(0.8),
                                Color.blue.opacity(0.6)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 180, height: 180)
                    .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 10)
                
                Text("Ox")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.top, 20)
            
            // Health Metrics Cards
            HStack(spacing: 12) {
                HealthMetricCard(
                    icon: "face.smiling.fill",
                    label: "Baby Cried",
                    value: "21 times",
                    color: .pink
                )
                
                HealthMetricCard(
                    icon: "thermometer",
                    label: "Body Temp",
                    value: "\(Int(healthMonitor.currentMetrics?.temperature ?? 36))°C",
                    color: .orange
                )
            }
            .padding(.horizontal, 20)
            
            // Oxygen Status
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Oxygen \(Int(healthMonitor.currentMetrics?.oxygenSaturation ?? 95))%")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Status Good")
                            .font(.system(size: 16))
                            .foregroundColor(.green)
                    }
                }
                
                Spacer()
            }
            .padding(20)
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .padding(.horizontal, 20)
            
            // Feeding Times Section
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Feeding times")
                        .font(AppTheme.fontHeadline)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .foregroundColor(AppTheme.primaryOrange)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                FeedingTimeRow(
                    title: "Time 1 (10:00 Everyday)",
                    isEnabled: $feedingTime1Enabled
                )
                
                FeedingTimeRow(
                    title: "Time 2 (18:00 Everyday)",
                    isEnabled: $feedingTime2Enabled
                )
            }
            .background(Color(red: 1.0, green: 0.95, blue: 0.9))
            .cornerRadius(16)
            .padding(.horizontal, 20)
            .padding(.top, 8)
        }
    }
}

struct HealthMetricCard: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundColor(color)
            
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }
}

struct FeedingTimeRow: View {
    let title: String
    @Binding var isEnabled: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 15))
                .foregroundColor(.primary)
            
            Spacer()
            
            Toggle("", isOn: $isEnabled)
                .labelsHidden()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

struct OtherDetailView: View {
    @EnvironmentObject var sensorService: SensorService
    @State private var currentTemp: Double = 16
    
    var body: some View {
        VStack(spacing: 24) {
            // Room Temperature Gauge
            VStack(spacing: 16) {
                ZStack {
                    // Circular gauge
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                        .frame(width: 200, height: 200)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(currentTemp / 40))
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .orange, .red]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            style: StrokeStyle(lineWidth: 20, lineCap: .round)
                        )
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(-90))
                    
                    VStack {
                        Text("\(Int(currentTemp))°C")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("Current Temperature")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 20)
            }
            
            // Temperature Cards
            HStack(spacing: 12) {
                TemperatureInfoCard(
                    icon: "thermometer",
                    label: "Avg Temp",
                    value: "\(Int(sensorService.currentSensorData?.roomTemperature ?? 36))°C"
                )
                
                TemperatureInfoCard(
                    icon: "chart.line.uptrend.xyaxis",
                    label: "Temp trend",
                    value: "Rising"
                )
                
                TemperatureInfoCard(
                    icon: "checkmark.circle.fill",
                    label: "Temp status",
                    value: "Normal",
                    valueColor: .green
                )
            }
            .padding(.horizontal, 20)
            
            // Falling History Section
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Falling history")
                        .font(AppTheme.fontHeadline)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .foregroundColor(AppTheme.primaryOrange)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                FallingHistoryRow(
                    title: "Fall 1 (Today 10:00)",
                    impact: "Impact Moderate",
                    heartRate: "HR 108BPM",
                    crying: "Crying Yes",
                    action: "Action Checked"
                )
                
                FallingHistoryRow(
                    title: "Fall 2 (22 Oct 15:00)",
                    impact: "Impact Low",
                    heartRate: "HR 103BPM",
                    crying: "Crying No",
                    action: "Action Resolved"
                )
            }
            .background(Color(red: 1.0, green: 0.95, blue: 0.9))
            .cornerRadius(16)
            .padding(.horizontal, 20)
            .padding(.top, 8)
        }
    }
}

struct TemperatureInfoCard: View {
    let icon: String
    let label: String
    let value: String
    var valueColor: Color = .primary
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.blue)
            
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(valueColor)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

struct FallingHistoryRow: View {
    let title: String
    let impact: String
    let heartRate: String
    let crying: String
    let action: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
            
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(impact)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    
                    Text(heartRate)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 6) {
                    Text(crying)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    
                    Text(action)
                        .font(.system(size: 14))
                        .foregroundColor(.green)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .padding(.horizontal, 20)
    }
}

