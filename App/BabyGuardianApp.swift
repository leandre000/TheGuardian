//
//  BabyGuardianApp.swift
//  BabyGuardian
//
//  Created on September 2025
//

import SwiftUI

@main
struct BabyGuardianApp: App {
    @StateObject private var healthMonitor = HealthMonitoringService()
    @StateObject private var alertManager = AlertManager()
    @StateObject private var sensorService = SensorService()
    @StateObject private var cryDetection = CryDetectionService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(healthMonitor)
                .environmentObject(alertManager)
                .environmentObject(sensorService)
                .environmentObject(cryDetection)
                .preferredColorScheme(.light)
                .onAppear {
                    setupAlertMonitoring()
                }
        }
    }
    
    private func setupAlertMonitoring() {
        // Monitor sensor service for alerts
        var lastBedEdgeAlert: Date?
        var lastGasAlert: Date?
        var lastSmokeAlert: Date?
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            if sensorService.isBedEdgeDetected {
                if lastBedEdgeAlert == nil || Date().timeIntervalSince(lastBedEdgeAlert!) > 30 {
                    alertManager.createAlert(type: .bedEdge, location: "Baby's Room")
                    lastBedEdgeAlert = Date()
                }
            }
            if sensorService.dangerousGasDetected {
                if lastGasAlert == nil || Date().timeIntervalSince(lastGasAlert!) > 30 {
                    alertManager.createAlert(type: .dangerousGas, location: "Baby's Room")
                    lastGasAlert = Date()
                }
            }
            if sensorService.smokeDetected {
                if lastSmokeAlert == nil || Date().timeIntervalSince(lastSmokeAlert!) > 30 {
                    alertManager.createAlert(type: .smoke, location: "Baby's Room")
                    lastSmokeAlert = Date()
                }
            }
        }
        
        // Monitor health metrics for alerts
        var lastHealthAlert: [SafetyAlert.AlertType: Date] = [:]
        
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            if let metrics = healthMonitor.currentMetrics {
                if metrics.heartRate < 100 || metrics.heartRate > 160 {
                    if lastHealthAlert[.heartRate] == nil || Date().timeIntervalSince(lastHealthAlert[.heartRate]!) > 60 {
                        alertManager.createAlert(type: .heartRate)
                        lastHealthAlert[.heartRate] = Date()
                    }
                }
                if metrics.temperature < 36.0 || metrics.temperature > 38.0 {
                    if lastHealthAlert[.temperature] == nil || Date().timeIntervalSince(lastHealthAlert[.temperature]!) > 60 {
                        alertManager.createAlert(type: .temperature)
                        lastHealthAlert[.temperature] = Date()
                    }
                }
                if metrics.oxygenSaturation < 95 {
                    if lastHealthAlert[.oxygen] == nil || Date().timeIntervalSince(lastHealthAlert[.oxygen]!) > 60 {
                        alertManager.createAlert(type: .oxygen)
                        lastHealthAlert[.oxygen] = Date()
                    }
                }
            }
        }
        
        // Monitor cry detection
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            if cryDetection.isCrying {
                // Create cry alert if not already created recently
                let recentCryAlerts = alertManager.activeAlerts.filter { 
                    $0.type == .cry && Date().timeIntervalSince($0.timestamp) < 30
                }
                if recentCryAlerts.isEmpty {
                    alertManager.createAlert(type: .cry)
                }
            }
        }
        
        // Start cry detection
        cryDetection.startCryDetection()
    }
}

