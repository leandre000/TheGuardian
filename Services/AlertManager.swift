//
//  AlertManager.swift
//  BabyGuardian
//
//  Alert management and notification system
//

import Foundation
import Combine
import AVFoundation
import AudioToolbox

class AlertManager: ObservableObject {
    @Published var activeAlerts: [SafetyAlert] = []
    @Published var unreadAlertCount: Int = 0
    
    private let alertClassification = AlertClassification.shared
    private var audioPlayer: AVAudioPlayer?
    private var soundAlertTimer: Timer?
    
    init() {
        // Monitor health and sensor services for alerts
    }
    
    func createAlert(type: SafetyAlert.AlertType, location: String? = nil) {
        let severity = alertClassification.classifyAlert(type: type)
        let message = alertClassification.getAlertMessage(for: SafetyAlert(
            id: UUID(),
            timestamp: Date(),
            type: type,
            severity: severity,
            message: "",
            location: location,
            isAcknowledged: false
        ))
        
        let alert = SafetyAlert(
            id: UUID(),
            timestamp: Date(),
            type: type,
            severity: severity,
            message: message,
            location: location,
            isAcknowledged: false
        )
        
        DispatchQueue.main.async {
            self.activeAlerts.insert(alert, at: 0)
            self.unreadAlertCount += 1
            
            // Play sound alert for critical/high priority alerts
            if self.alertClassification.shouldPlaySoundAlert(for: alert) {
                self.playSoundAlert()
            }
        }
        
        // Send local notification
        sendLocalNotification(for: alert)
    }
    
    func acknowledgeAlert(_ alert: SafetyAlert) {
        if let index = activeAlerts.firstIndex(where: { $0.id == alert.id }) {
            let updatedAlert = SafetyAlert(
                id: alert.id,
                timestamp: alert.timestamp,
                type: alert.type,
                severity: alert.severity,
                message: alert.message,
                location: alert.location,
                isAcknowledged: true
            )
            activeAlerts[index] = updatedAlert
            if unreadAlertCount > 0 {
                unreadAlertCount -= 1
            }
        }
    }
    
    func clearAllAlerts() {
        activeAlerts.removeAll()
        unreadAlertCount = 0
    }
    
    private func playSoundAlert() {
        // Play system alert sound
        AudioServicesPlaySystemSound(1005) // System alert sound
        
        // Optionally play custom alert sound
        if let soundURL = Bundle.main.url(forResource: "alert_sound", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing alert sound: \(error)")
            }
        }
    }
    
    private func sendLocalNotification(for alert: SafetyAlert) {
        // In production, use UNUserNotificationCenter for proper notifications
        print("📢 Notification: \(alert.message)")
    }
    
    func getCriticalAlerts() -> [SafetyAlert] {
        return activeAlerts.filter { $0.severity == .critical }
    }
    
    func getHighPriorityAlerts() -> [SafetyAlert] {
        return activeAlerts.filter { $0.severity == .high }
    }
}

