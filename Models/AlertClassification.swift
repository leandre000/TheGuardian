//
//  AlertClassification.swift
//  BabyGuardian
//
//  Alert classification and priority system
//

import Foundation

class AlertClassification {
    static let shared = AlertClassification()
    
    // Critical alerts that require immediate sound notification
    private let criticalAlertTypes: [SafetyAlert.AlertType] = [
        .fall,
        .dangerousGas,
        .smoke,
        .bedEdge
    ]
    
    // High priority alerts
    private let highPriorityAlertTypes: [SafetyAlert.AlertType] = [
        .heartRate,
        .oxygen,
        .temperature
    ]
    
    func classifyAlert(type: SafetyAlert.AlertType) -> SafetyAlert.AlertSeverity {
        if criticalAlertTypes.contains(type) {
            return .critical
        } else if highPriorityAlertTypes.contains(type) {
            return .high
        } else if type == .cry {
            return .medium
        } else {
            return .low
        }
    }
    
    func shouldPlaySoundAlert(for alert: SafetyAlert) -> Bool {
        return alert.severity.requiresSoundAlert
    }
    
    func getAlertMessage(for alert: SafetyAlert) -> String {
        switch alert.type {
        case .fall:
            return "⚠️ CRITICAL: Baby may have fallen! Immediate attention required!"
        case .dangerousGas:
            return "🚨 DANGER: Dangerous gas detected in baby's room! Evacuate immediately!"
        case .smoke:
            return "🔥 FIRE ALERT: Smoke detected! Check baby's room immediately!"
        case .bedEdge:
            return "⚠️ WARNING: Baby is near bed edge! Risk of falling!"
        case .heartRate:
            return "💓 Alert: Heart rate is outside normal range"
        case .oxygen:
            return "🫁 Alert: Oxygen saturation is low"
        case .temperature:
            return "🌡️ Alert: Temperature is outside safe range"
        case .cry:
            return "👶 Baby is crying - comfort system activated"
        }
    }
}

