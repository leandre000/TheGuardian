//
//  SensorService.swift
//  BabyGuardian
//
//  Sensor service for bed edge, room conditions, and dangerous gases
//

import Foundation
import Combine

class SensorService: ObservableObject {
    @Published var currentSensorData: SensorData?
    @Published var isBedEdgeDetected: Bool = false
    @Published var dangerousGasDetected: Bool = false
    @Published var smokeDetected: Bool = false
    
    private var updateTimer: Timer?
    private let updateInterval: TimeInterval = 1.0 // Update every second
    
    init() {
        startSensorMonitoring()
    }
    
    func startSensorMonitoring() {
        updateTimer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { [weak self] _ in
            self?.updateSensorData()
        }
        updateSensorData()
    }
    
    func stopSensorMonitoring() {
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    private func updateSensorData() {
        // Simulate sensor data (in production, this would come from IoT sensors)
        let sensorData = SensorData(
            timestamp: Date(),
            bedEdgeDetected: Bool.random() && Double.random(in: 0...1) < 0.1, // 10% chance
            roomTemperature: Double.random(in: 20...25),
            roomHumidity: Double.random(in: 40...60),
            airQuality: [.excellent, .good, .moderate, .poor].randomElement() ?? .good,
            dangerousGasDetected: Bool.random() && Double.random(in: 0...1) < 0.05, // 5% chance
            smokeDetected: Bool.random() && Double.random(in: 0...1) < 0.03, // 3% chance
            gasType: Bool.random() ? "CO" : nil
        )
        
        DispatchQueue.main.async {
            self.currentSensorData = sensorData
            self.isBedEdgeDetected = sensorData.bedEdgeDetected
            self.dangerousGasDetected = sensorData.dangerousGasDetected
            self.smokeDetected = sensorData.smokeDetected
        }
    }
}

