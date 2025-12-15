//
//  AlertsView.swift
//  BabyGuardian
//
//  Alerts management and history view
//

import SwiftUI

struct AlertsView: View {
    @EnvironmentObject var alertManager: AlertManager
    @State private var filterOption: FilterOption = .all
    
    enum FilterOption: String, CaseIterable {
        case all = "All"
        case critical = "Critical"
        case high = "High Priority"
        case unread = "Unread"
    }
    
    var filteredAlerts: [SafetyAlert] {
        switch filterOption {
        case .all:
            return alertManager.activeAlerts
        case .critical:
            return alertManager.activeAlerts.filter { $0.severity == .critical }
        case .high:
            return alertManager.activeAlerts.filter { $0.severity == .high }
        case .unread:
            return alertManager.activeAlerts.filter { !$0.isAcknowledged }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Filter Picker
                Picker("Filter", selection: $filterOption) {
                    ForEach(FilterOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                // Alerts List
                if filteredAlerts.isEmpty {
                    EmptyAlertsView()
                } else {
                    List {
                        ForEach(filteredAlerts) { alert in
                            AlertDetailRow(alert: alert)
                                .swipeActions(edge: .trailing) {
                                    if !alert.isAcknowledged {
                                        Button("Acknowledge") {
                                            alertManager.acknowledgeAlert(alert)
                                        }
                                        .tint(.blue)
                                    }
                                }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Alerts")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !alertManager.activeAlerts.isEmpty {
                        Button("Clear All") {
                            alertManager.clearAllAlerts()
                        }
                    }
                }
            }
        }
    }
}

struct EmptyAlertsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)
            
            Text("No Alerts")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("All systems are operating normally")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AlertDetailRow: View {
    let alert: SafetyAlert
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                // Severity Indicator
                Circle()
                    .fill(severityColor)
                    .frame(width: 12, height: 12)
                
                Text(alert.type.rawValue)
                    .font(.headline)
                
                Spacer()
                
                if !alert.isAcknowledged {
                    Text("NEW")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            
            Text(alert.message)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Label(alert.timestamp, style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if let location = alert.location {
                    Spacer()
                    Label(location, systemImage: "location.fill")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // Severity Badge
            HStack {
                Text(alert.severity.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(severityColor)
                    .cornerRadius(8)
                
                if alert.severity.requiresSoundAlert {
                    HStack(spacing: 4) {
                        Image(systemName: "speaker.wave.2.fill")
                        Text("Sound Alert")
                    }
                    .font(.caption)
                    .foregroundColor(.orange)
                }
            }
        }
        .padding()
        .background(alert.isAcknowledged ? Color(.systemGray6) : Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(severityColor.opacity(0.3), lineWidth: alert.isAcknowledged ? 0 : 2)
        )
    }
    
    private var severityColor: Color {
        switch alert.severity {
        case .critical: return .red
        case .high: return .orange
        case .medium: return .yellow
        case .low: return .blue
        }
    }
}

