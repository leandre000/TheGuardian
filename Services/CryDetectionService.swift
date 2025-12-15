//
//  CryDetectionService.swift
//  BabyGuardian
//
//  Cry detection and comfort system
//

import Foundation
import Combine
import AVFoundation

class CryDetectionService: ObservableObject {
    @Published var isCrying: Bool = false
    @Published var cryIntensity: Double = 0.0
    @Published var autoComfortActive: Bool = false
    
    private var detectionTimer: Timer?
    private var audioPlayer: AVAudioPlayer?
    
    func startCryDetection() {
        detectionTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.detectCry()
        }
    }
    
    func stopCryDetection() {
        detectionTimer?.invalidate()
        detectionTimer = nil
        stopComfortSound()
    }
    
    private func detectCry() {
        // Simulate cry detection (in production, this would use ML model on audio feed)
        let detected = Bool.random() && Double.random(in: 0...1) < 0.15 // 15% chance
        
        DispatchQueue.main.async {
            self.isCrying = detected
            if detected {
                self.cryIntensity = Double.random(in: 0.5...1.0)
                self.triggerAutoComfort()
            } else {
                self.cryIntensity = 0.0
                self.stopComfortSound()
            }
        }
    }
    
    private func triggerAutoComfort() {
        guard !autoComfortActive else { return }
        
        autoComfortActive = true
        playLullaby()
    }
    
    func notifyCryDetected() {
        // This will be called from the app to notify alert manager
    }
    
    private func playLullaby() {
        // Play pre-recorded lullaby or mother's voice
        // In production, this would play from device or cloud storage
        print("🎵 Playing lullaby to comfort baby...")
    }
    
    private func stopComfortSound() {
        audioPlayer?.stop()
        autoComfortActive = false
    }
}

