//
//  SignupBabyView.swift
//  BabyGuardian
//
//  Sign up form - Step 2: Baby Information
//

import SwiftUI

struct SignupBabyView: View {
    @Binding var currentStep: OnboardingState.OnboardingStep
    @EnvironmentObject var formData: SignupFormData
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Progress indicator
                        ProgressIndicator(currentStep: 2, totalSteps: 3, stepLabel: "Baby")
                            .padding(.top, 20)
                        
                        VStack(spacing: 20) {
                            // Baby's Name
                            CustomTextField(
                                title: "Baby's Name",
                                text: $formData.babyData.name,
                                placeholder: "Enter baby's name",
                                icon: "person.fill"
                            )
                            
                            // Date of Birth
                            DatePickerField(
                                title: "Date Of Birth",
                                date: $formData.babyData.dateOfBirth
                            )
                            
                            // Gender
                            PickerField(
                                title: "Gender",
                                selection: $formData.babyData.gender,
                                options: BabySignupData.Gender.allCases
                            )
                            
                            // Weight
                            WeightField(
                                title: "Weight",
                                weight: $formData.babyData.weight,
                                unit: $formData.babyData.weightUnit
                            )
                            
                            // Allergies/Notes
                            TextAreaField(
                                title: "Allergies/Notes (if any)",
                                text: $formData.babyData.allergies,
                                placeholder: "Enter any allergies or notes"
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        
                        // Next Button
                        Button(action: {
                            if validateBabyData() {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    currentStep = .signupEmergency
                                }
                            }
                        }) {
                            Text("Next")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 1.0, green: 0.6, blue: 0.0),
                                            Color(red: 1.0, green: 0.5, blue: 0.0)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(14)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation {
                            currentStep = .signupParent
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
    
    private func validateBabyData() -> Bool {
        return !formData.babyData.name.isEmpty &&
               !formData.babyData.weight.isEmpty
    }
}

struct DatePickerField: View {
    let title: String
    @Binding var date: Date
    @State private var showDatePicker = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.secondary)
            
            Button(action: {
                showDatePicker.toggle()
            }) {
                HStack {
                    Text(dateFormatter.string(from: date))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            }
        }
        .sheet(isPresented: $showDatePicker) {
            DatePickerSheet(date: $date, isPresented: $showDatePicker)
        }
    }
}

struct DatePickerSheet: View {
    @Binding var date: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "Date of Birth",
                    selection: $date,
                    displayedComponents: .date
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Select Date")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

struct PickerField<T: Hashable & RawRepresentable>: View where T.RawValue == String {
    let title: String
    @Binding var selection: T
    let options: [T]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.secondary)
            
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selection = option
                    }) {
                        HStack {
                            Text(option.rawValue)
                            if selection == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selection.rawValue)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.secondary)
                        .font(.system(size: 12))
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            }
        }
    }
}

struct WeightField: View {
    let title: String
    @Binding var weight: String
    @Binding var unit: BabySignupData.WeightUnit
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.secondary)
            
            HStack {
                TextField("0", text: $weight)
                    .keyboardType(.decimalPad)
                    .frame(maxWidth: .infinity)
                
                Picker("", selection: $unit) {
                    ForEach(BabySignupData.WeightUnit.allCases, id: \.self) { unitOption in
                        Text(unitOption.rawValue).tag(unitOption)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 80)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

struct TextAreaField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.secondary)
            
            TextEditor(text: $text)
                .frame(height: 100)
                .padding(8)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .overlay(
                    Group {
                        if text.isEmpty {
                            Text(placeholder)
                                .foregroundColor(.secondary.opacity(0.5))
                                .padding(.leading, 12)
                                .padding(.top, 16)
                                .allowsHitTesting(false)
                        }
                    },
                    alignment: .topLeading
                )
        }
    }
}

