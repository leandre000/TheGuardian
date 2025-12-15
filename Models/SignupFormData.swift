//
//  SignupFormData.swift
//  BabyGuardian
//
//  Combined signup form data model
//

import Foundation

class SignupFormData: ObservableObject {
    @Published var parentData = ParentSignupData()
    @Published var babyData = BabySignupData()
    @Published var emergencyData = EmergencyContactData()
    @Published var consentData = ConsentData()
    
    func reset() {
        parentData = ParentSignupData()
        babyData = BabySignupData()
        emergencyData = EmergencyContactData()
        consentData = ConsentData()
    }
}

