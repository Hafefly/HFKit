//
//  SignUpInfoViewModel.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 17/10/2023.
//

import Foundation
import Combine
import HFNavigation
import HFCoreUI

extension SignUpInfoView {
    class Model: ObservableObject {
        
        @Published public private(set) var firstnameUiState: UiState<String> = .idle
        @Published public private(set) var lastnameUiState: UiState<String> = .idle
        @Published public private(set) var phoneNumberUiState: UiState<String> = .idle
        
        @Published public private(set) var otpFieldOpacity = 0
        @Published public private(set) var timeCounting = 60000
        @Published public private(set) var otpButtonText = "send otp"
        
        @Published public private(set) var otpButtonDisabled = true
        @Published public private(set) var continueButtonDisabled = true
        
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        @Published public var otpFields: [String] = Array(repeating: "", count: 6)
        
        func sendOtp(phonenumber: String) {
            self.otpButtonDisabled = true
            #warning("send otp here")
        }
        
        func verifyOtp(for phonenumber: String, code otpCode: String) -> Bool {
            #warning("verify otp here")
            
            return validatePhoneFormat(phonenumber)
        }
        
        @discardableResult
        func validateName(_ name: String) -> Bool {
            let nameRegex = "^[A-Za-z]+([ '-][A-Za-z]+)*$"
            
            return name.regexChecker(with: nameRegex)
        }
        
        func setFirstnameUiState(_ success: Bool) {
            if success {
                self.firstnameUiState = .success("name in correct format")
            } else {
                self.firstnameUiState = .failed("name format is wrong")
            }
        }
        
        func setLastnameUiState(_ success: Bool) {
            if success {
                self.lastnameUiState = .success("name in correct format")
            } else {
                self.lastnameUiState = .failed("name format is wrong")
            }
        }
        
        @discardableResult
        func validatePhoneFormat(_ number: String) -> Bool {
            let phoneRegex = #"^\d{10}$"#
            
            let result = number.regexChecker(with: phoneRegex)
            if result {
                self.phoneNumberUiState = .success("phone in correct format")
            } else {
                self.phoneNumberUiState = .failed("phone should contain 10 characters")
            }
            
            return result
        }
        
        func checkInfo(firstname: String, lastname: String, province: Province, phoneNumber: String, otpCode: String, success: @escaping (T, Bool) -> Void) {
            if validateName(firstname),
               validateName(lastname),
               verifyOtp(for: phoneNumber, code: otpCode) {
                NavigationCoordinator.pushScreen(SignUpView(firstname: firstname, lastname: lastname, province: province, phonenumber: phoneNumber, success: success))
            }
        }
        
        func updateActiveField(value: [String], codeLength: Int, activeField: OTPField?, nextActiveField: @escaping (OTPField?) -> Void) {
            for index in 1 ... (codeLength - 1){
                if value[index].isEmpty && !value[index - 1].isEmpty {
                    nextActiveField(activeStateForIndex(index: index - 1))
                }
            }
            
            for index in 0 ..< (codeLength - 1){
                if value[index].count == 1 && activeStateForIndex(index: index) == activeField {
                    nextActiveField(activeStateForIndex(index: index + 1))
                }
            }
            for index in 0 ..< codeLength {
                if value[index].count > 1 {
                    otpFields[index] = String(value[index].last!)
                }
            }
        }
        
        func activeStateForIndex(index: Int) -> OTPField {
            switch index {
            case 0: return .field1
            case 1: return .field2
            case 2: return .field3
            case 3: return .field4
            case 4: return .field5
            default: return .field6
            }
        }
        
        func handleAutoFill(value: [String], codeLength: Int) -> Bool {
            for item in value {
                if item.count == codeLength {
                    for i in 0...(codeLength - 1) {
                        otpFields[i] = String(Array(item)[i])
                    }
                    return true
                }
            }
            if otpFields.joined().count == codeLength { return true }
            return false
        }
        
        func timerCountdown(timer: Publishers.Autoconnect<Timer.TimerPublisher>.Output) {
            if timeCounting > 0 {
                timeCounting -= 1000
            } else if timeCounting == 0 {
                self.timeCounting = 60000
            }
        }
        
        private func showOtpFields() {
            self.otpFieldOpacity = 1
        }
        
        func otpButtonDisabledd() -> Bool {
            switch phoneNumberUiState {
            case .success:
                return timeCounting == 60000
            default: return false
            }
        }
    }
}
