//
//  DashboardView.swift
//  BabyGuardian
//
//  Main dashboard with health metrics overview
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var sensorService: SensorService
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Status Header
                    StatusHeaderView()
                        .padding(.horizontal)
                    
                    // Critical Alerts Banner
                    if !alertManager.getCriticalAlerts().isEmpty {
                        CriticalAlertsBanner()
                            .padding(.horizontal)
                    }
                    
                    // Health Metrics Cards
                    HealthMetricsGridView()
                        .padding(.horizontal)
                    
                    // Safety Status
                    SafetyStatusView()
                        .padding(.horizontal)
                    
                    // Quick Actions
                    QuickActionsView()
                        .padding(.horizontal)
                    
                    // Recent Activity
                    RecentActivityView()
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("BabyGuardian")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                // Refresh data
            }
        }
    }
}

struct StatusHeaderView: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    @EnvironmentObject var alertManager: AlertManager
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Baby Status")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                HStack {
                    Circle()
                        .fill(healthMonitor.isConnected ? Color.green : Color.red)
                        .frame(width: 12, height: 12)
                    
                    Text(healthMonitor.isConnected ? "Connected" : "Disconnected")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            
            Spacer()
            
            if alertManager.unreadAlertCount > 0 {
                ZStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 50, height: 50)
                    
                    Text("\(alertManager.unreadAlertCount)")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct CriticalAlertsBanner: View {
    @EnvironmentObject var alertManager: AlertManager
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text("Critical Alert")
                    .font(.headline)
                Text("\(alertManager.getCriticalAlerts().count) critical alert(s) require immediate attention")
                    .font(.caption)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
        .padding()
        .background(Color.red.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.red, lineWidth: 2)
        )
    }
}

struct HealthMetricsGridView: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
            MetricCard(
                title: "Heart Rate",
                value: "\(healthMonitor.currentMetrics?.heartRate ?? 0)",
                unit: "BPM",
                icon: "heart.fill",
                color: .red
            )
            
            MetricCard(
                title: "Temperature",
                value: String(format: "%.1f", healthMonitor.currentMetrics?.temperature ?? 0.0),
                unit: "°C",
                icon: "thermometer",
                color: .orange
            )
            
            MetricCard(
                title: "Oxygen",
                value: String(format: "%.0f", healthMonitor.currentMetrics?.oxygenSaturation ?? 0),
                unit: "%",
                icon: "lungs.fill",
                color: .blue
            )
            
            MetricCard(
                title: "Sleep",
                value: healthMonitor.currentMetrics?.sleepQuality.rawValue ?? "Unknown",
                unit: "",
                icon: "moon.fill",
                color: .purple
            )
        }
    }
}

struct MetricCard: View {
    let title: String
    let value: String
    let unit: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Spacer()
            }
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            
            HStack(alignment: .firstTextBaseline) {
                Text(unit)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct SafetyStatusView: View {
    @EnvironmentObject var sensorService: SensorService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Safety Status")
                .font(.headline)
                .padding(.horizontal)
            
            SafetyStatusRow(
                icon: "bed.double.fill",
                title: "Bed Edge",
                status: sensorService.isBedEdgeDetected ? "⚠️ Alert" : "✅ Safe",
                isSafe: !sensorService.isBedEdgeDetected
            )
            
            SafetyStatusRow(
                icon: "wind",
                title: "Air Quality",
                status: sensorService.currentSensorData?.airQuality.rawValue ?? "Good",
                isSafe: sensorService.currentSensorData?.airQuality != .hazardous
            )
            
            SafetyStatusRow(
                icon: "exclamationmark.triangle.fill",
                title: "Dangerous Gas",
                status: sensorService.dangerousGasDetected ? "🚨 DETECTED" : "✅ Safe",
                isSafe: !sensorService.dangerousGasDetected
            )
            
            SafetyStatusRow(
                icon: "flame.fill",
                title: "Smoke",
                status: sensorService.smokeDetected ? "🔥 DETECTED" : "✅ Safe",
                isSafe: !sensorService.smokeDetected
            )
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct SafetyStatusRow: View {
    let icon: String
    let title: String
    let status: String
    let isSafe: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(isSafe ? .green : .red)
                .frame(width: 24)
            
            Text(title)
                .font(.body)
            
            Spacer()
            
            Text(status)
                .font(.subheadline)
                .fontWeight(isSafe ? .regular : .bold)
                .foregroundColor(isSafe ? .green : .red)
        }
        .padding(.horizontal)
    }
}

struct QuickActionsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.headline)
                .padding(.horizontal)
            
            HStack(spacing: 15) {
                QuickActionButton(icon: "camera.fill", title: "View Camera", color: .blue)
                QuickActionButton(icon: "bell.fill", title: "Alerts", color: .orange)
                QuickActionButton(icon: "chart.line.uptrend.xyaxis", title: "Analytics", color: .purple)
                QuickActionButton(icon: "person.crop.circle.fill", title: "Share Report", color: .green)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
        }
    }
}

struct RecentActivityView: View {
    @EnvironmentObject var alertManager: AlertManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Alerts")
                .font(.headline)
            
            if alertManager.activeAlerts.isEmpty {
                Text("No recent alerts")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ForEach(Array(alertManager.activeAlerts.prefix(3))) { alert in
                    AlertRowView(alert: alert)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct AlertRowView: View {
    let alert: SafetyAlert
    
    var body: some View {
        HStack {
            Circle()
                .fill(alert.severity == .critical ? Color.red : Color.orange)
                .frame(width: 8, height: 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(alert.type.rawValue)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(alert.timestamp, style: .relative)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if !alert.isAcknowledged {
                Image(systemName: "circle.fill")
                    .foregroundColor(.blue)
                    .font(.caption)
            }
        }
        .padding(.vertical, 4)
    }
}

