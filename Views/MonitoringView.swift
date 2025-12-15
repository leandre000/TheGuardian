//
//  MonitoringView.swift
//  BabyGuardian
//
//  Detailed health monitoring view
//

import SwiftUI

struct MonitoringView: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    @EnvironmentObject var sensorService: SensorService
    
    @State private var selectedTimeRange: TimeRange = .hour
    
    enum TimeRange: String, CaseIterable {
        case hour = "Last Hour"
        case day = "Last 24 Hours"
        case week = "Last Week"
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Connection Status
                    ConnectionStatusCard()
                        .padding(.horizontal)
                    
                    // Time Range Selector
                    Picker("Time Range", selection: $selectedTimeRange) {
                        ForEach(TimeRange.allCases, id: \.self) { range in
                            Text(range.rawValue).tag(range)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    // Health Charts
                    HealthChartView(metric: .heartRate, color: .red)
                        .padding(.horizontal)
                    
                    HealthChartView(metric: .temperature, color: .orange)
                        .padding(.horizontal)
                    
                    HealthChartView(metric: .oxygen, color: .blue)
                        .padding(.horizontal)
                    
                    // Detailed Metrics
                    DetailedMetricsView()
                        .padding(.horizontal)
                    
                    // Environmental Data
                    EnvironmentalDataView()
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Health Monitoring")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ConnectionStatusCard: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Wearable Device")
                    .font(.headline)
                
                HStack {
                    Circle()
                        .fill(healthMonitor.isConnected ? Color.green : Color.red)
                        .frame(width: 10, height: 10)
                    Text(healthMonitor.isConnected ? "Connected" : "Disconnected")
                        .font(.subheadline)
                }
            }
            
            Spacer()
            
            if healthMonitor.isConnected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title2)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

enum HealthMetric {
    case heartRate
    case temperature
    case oxygen
}

struct HealthChartView: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    let metric: HealthMetric
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(metricTitle)
                .font(.headline)
            
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(Array(healthMonitor.metricsHistory.enumerated()), id: \.element.id) { index, metric in
                        LineMark(
                            x: .value("Time", index),
                            y: .value("Value", metricValue(metric))
                        )
                        .foregroundStyle(color)
                    }
                }
                .frame(height: 150)
            } else {
                // Fallback for iOS < 16 - show simple line graph
                SimpleLineGraph(data: healthMonitor.metricsHistory.map { metricValue($0) }, color: color)
                    .frame(height: 150)
            }
            
            HStack {
                Text("Current: \(currentValue)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text("Average: \(averageValue)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    private var metricTitle: String {
        switch metric {
        case .heartRate: return "Heart Rate (BPM)"
        case .temperature: return "Temperature (°C)"
        case .oxygen: return "Oxygen Saturation (%)"
        }
    }
    
    private func metricValue(_ healthMetric: HealthMetrics) -> Double {
        switch metric {
        case .heartRate: return Double(healthMetric.heartRate)
        case .temperature: return healthMetric.temperature
        case .oxygen: return healthMetric.oxygenSaturation
        }
    }
    
    private var currentValue: String {
        guard let current = healthMonitor.currentMetrics else { return "N/A" }
        switch metric {
        case .heartRate: return "\(current.heartRate) BPM"
        case .temperature: return String(format: "%.1f°C", current.temperature)
        case .oxygen: return String(format: "%.0f%%", current.oxygenSaturation)
        }
    }
    
    private var averageValue: String {
        let recent = Array(healthMonitor.metricsHistory.suffix(30))
        guard !recent.isEmpty else { return "N/A" }
        
        switch metric {
        case .heartRate:
            let avg = Double(recent.map { $0.heartRate }.reduce(0, +)) / Double(recent.count)
            return String(format: "%.0f BPM", avg)
        case .temperature:
            let avg = recent.map { $0.temperature }.reduce(0, +) / Double(recent.count)
            return String(format: "%.1f°C", avg)
        case .oxygen:
            let avg = recent.map { $0.oxygenSaturation }.reduce(0, +) / Double(recent.count)
            return String(format: "%.0f%%", avg)
        }
    }
}

struct DetailedMetricsView: View {
    @EnvironmentObject var healthMonitor: HealthMonitoringService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Detailed Metrics")
                .font(.headline)
            
            if let metrics = healthMonitor.currentMetrics {
                MetricDetailRow(label: "Heart Rate", value: "\(metrics.heartRate) BPM", status: getHeartRateStatus(metrics.heartRate))
                MetricDetailRow(label: "Temperature", value: String(format: "%.1f°C", metrics.temperature), status: getTemperatureStatus(metrics.temperature))
                MetricDetailRow(label: "Oxygen Saturation", value: String(format: "%.1f%%", metrics.oxygenSaturation), status: getOxygenStatus(metrics.oxygenSaturation))
                MetricDetailRow(label: "Sleep Quality", value: metrics.sleepQuality.rawValue, status: .normal)
                MetricDetailRow(label: "Activity", value: metrics.isActive ? "Active" : "Resting", status: .normal)
            } else {
                Text("No data available")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    enum Status {
        case normal
        case warning
        case critical
    }
    
    private func getHeartRateStatus(_ rate: Int) -> Status {
        if rate < 100 || rate > 160 {
            return rate < 80 || rate > 180 ? .critical : .warning
        }
        return .normal
    }
    
    private func getTemperatureStatus(_ temp: Double) -> Status {
        if temp < 36.0 || temp > 38.0 {
            return temp < 35.0 || temp > 39.0 ? .critical : .warning
        }
        return .normal
    }
    
    private func getOxygenStatus(_ oxygen: Double) -> Status {
        if oxygen < 95 {
            return oxygen < 90 ? .critical : .warning
        }
        return .normal
    }
}

struct MetricDetailRow: View {
    let label: String
    let value: String
    let status: DetailedMetricsView.Status
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
            
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)
        }
    }
    
    private var statusColor: Color {
        switch status {
        case .normal: return .green
        case .warning: return .orange
        case .critical: return .red
        }
    }
}

struct EnvironmentalDataView: View {
    @EnvironmentObject var sensorService: SensorService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Environmental Data")
                .font(.headline)
            
            if let data = sensorService.currentSensorData {
                EnvironmentalRow(label: "Room Temperature", value: String(format: "%.1f°C", data.roomTemperature))
                EnvironmentalRow(label: "Humidity", value: String(format: "%.0f%%", data.roomHumidity))
                EnvironmentalRow(label: "Air Quality", value: data.airQuality.rawValue)
            } else {
                Text("No sensor data available")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct EnvironmentalRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}

