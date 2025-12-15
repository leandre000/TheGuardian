//
//  OnboardingModels.swift
//  BabyGuardian
//
//  Models for onboarding and signup flow
//

import Foundation

class OnboardingState: ObservableObject {
    @Published var hasCompletedOnboarding: Bool = false
    @Published var currentStep: OnboardingStep = .splash
    
    enum OnboardingStep {
        case splash
        case features
        case signupParent
        case signupBaby
        case signupEmergency
        case completed
    }
}

struct ParentSignupData {
    var fullName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var password: String = ""
    var confirmPassword: String = ""
}

struct BabySignupData {
    var name: String = ""
    var dateOfBirth: Date = Date()
    var gender: Gender = .female
    var weight: String = ""
    var weightUnit: WeightUnit = .kg
    var allergies: String = ""
    
    enum Gender: String, CaseIterable {
        case male = "Male"
        case female = "Female"
        case other = "Other"
    }
    
    enum WeightUnit: String, CaseIterable {
        case kg = "kg"
        case lb = "lb"
    }
}

struct EmergencyContactData {
    var name: String = ""
    var relationship: Relationship = .mother
    var phoneNumber: String = ""
    
    enum Relationship: String, CaseIterable {
        case mother = "Mother"
        case father = "Father"
        case grandparent = "Grandparent"
        case guardian = "Guardian"
        case other = "Other"
    }
}

struct ConsentData {
    var dataCollectionConsent: Bool = false
    var privacyPolicyConsent: Bool = false
    var monitoringAssistantConsent: Bool = false
}

