//
//  HealthData.swift
//  BabyGuardian
//
//  Health monitoring data models
//

import Foundation

struct HealthMetrics: Codable, Identifiable {
    let id: UUID
    let timestamp: Date
    let temperature: Double // Celsius
    let heartRate: Int // BPM
    let oxygenSaturation: Double // SpO2 percentage
    let sleepQuality: SleepQuality
    let isActive: Bool
    
    enum SleepQuality: String, Codable {
        case deep = "Deep Sleep"
        case light = "Light Sleep"
        case awake = "Awake"
        case restless = "Restless"
    }
}

struct SafetyAlert: Codable, Identifiable {
    let id: UUID
    let timestamp: Date
    let type: AlertType
    let severity: AlertSeverity
    let message: String
    let location: String?
    let isAcknowledged: Bool
    
    enum AlertType: String, Codable {
        case bedEdge = "Bed Edge Detection"
        case dangerousGas = "Dangerous Gas Detected"
        case smoke = "Smoke Detected"
        case temperature = "Temperature Alert"
        case heartRate = "Heart Rate Alert"
        case oxygen = "Oxygen Alert"
        case cry = "Cry Detected"
        case fall = "Fall Detection"
    }
    
    enum AlertSeverity: String, Codable {
        case critical = "Critical"
        case high = "High"
        case medium = "Medium"
        case low = "Low"
        
        var requiresSoundAlert: Bool {
            return self == .critical || self == .high
        }
    }
}

struct SensorData: Codable {
    let timestamp: Date
    let bedEdgeDetected: Bool
    let roomTemperature: Double
    let roomHumidity: Double
    let airQuality: AirQuality
    let dangerousGasDetected: Bool
    let smokeDetected: Bool
    let gasType: String?
    
    enum AirQuality: String, Codable {
        case excellent = "Excellent"
        case good = "Good"
        case moderate = "Moderate"
        case poor = "Poor"
        case hazardous = "Hazardous"
    }
}

struct CryDetection: Codable {
    let timestamp: Date
    let isCrying: Bool
    let intensity: Double // 0.0 to 1.0
    let duration: TimeInterval
    let autoComfortTriggered: Bool
}

struct AIInsight: Codable, Identifiable {
    let id: UUID
    let timestamp: Date
    let type: InsightType
    let message: String
    let confidence: Double
    
    enum InsightType: String, Codable {
        case feeding = "Feeding Prediction"
        case sleep = "Sleep Cycle"
        case health = "Health Anomaly"
        case comfort = "Comfort Recommendation"
    }
}

