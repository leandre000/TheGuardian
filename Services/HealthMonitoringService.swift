//
//  HealthMonitoringService.swift
//  BabyGuardian
//
//  Health monitoring service for wearable device data
//

import Foundation
import Combine

class HealthMonitoringService: ObservableObject {
    @Published var currentMetrics: HealthMetrics?
    @Published var metricsHistory: [HealthMetrics] = []
    @Published var isConnected: Bool = false
    
    private var updateTimer: Timer?
    private let updateInterval: TimeInterval = 2.0 // Update every 2 seconds
    
    init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        // Simulate wearable connection
        isConnected = true
        
        // Start periodic updates
        updateTimer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { [weak self] _ in
            self?.updateMetrics()
        }
        
        // Initial update
        updateMetrics()
    }
    
    func stopMonitoring() {
        updateTimer?.invalidate()
        updateTimer = nil
        isConnected = false
    }
    
    private func updateMetrics() {
        // Simulate health data (in production, this would come from wearable device)
        let metrics = HealthMetrics(
            id: UUID(),
            timestamp: Date(),
            temperature: Double.random(in: 36.5...37.5),
            heartRate: Int.random(in: 100...160),
            oxygenSaturation: Double.random(in: 95...100),
            sleepQuality: [.deep, .light, .awake, .restless].randomElement() ?? .light,
            isActive: Bool.random()
        )
        
        DispatchQueue.main.async {
            self.currentMetrics = metrics
            self.metricsHistory.append(metrics)
            
            // Keep only last 100 readings
            if self.metricsHistory.count > 100 {
                self.metricsHistory.removeFirst()
            }
        }
    }
    
    func getAverageHeartRate(over minutes: Int = 5) -> Double {
        let cutoff = Date().addingTimeInterval(-Double(minutes * 60))
        let recent = metricsHistory.filter { $0.timestamp >= cutoff }
        guard !recent.isEmpty else { return 0 }
        return Double(recent.map { $0.heartRate }.reduce(0, +)) / Double(recent.count)
    }
    
    func getAverageTemperature(over minutes: Int = 5) -> Double {
        let cutoff = Date().addingTimeInterval(-Double(minutes * 60))
        let recent = metricsHistory.filter { $0.timestamp >= cutoff }
        guard !recent.isEmpty else { return 0 }
        return recent.map { $0.temperature }.reduce(0, +) / Double(recent.count)
    }
}

