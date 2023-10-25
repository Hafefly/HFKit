//
//  SignUpInfoViewModel.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 17/10/2023.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth
import HFNavigation
import HFCoreUI

enum OTPButtonUiState: Equatable {
    case disabled(Int)
    case valid(Int)
    case success
    
    var backgroundColor: Color {
        switch self {
        case .disabled:
            return .gray
        case .valid:
            return .hfOrange
        case .success:
            return .green
        }
    }
    
    var text: String {
        switch self {
        case .disabled(let count), .valid(let count):
            return count > 0 ? "resend otp" : "send otp"
        case .success:
            return "done"
        }
    }
    
    var disabled: Bool {
        if case .valid = self {
            return false
        }
        
        return true
    }
}

extension SignUpInfoView {
    class Model: ObservableObject {
        
        @Published public private(set) var firstnameUiState: UiState<String> = .idle
        @Published public private(set) var lastnameUiState: UiState<String> = .idle
        @Published public private(set) var phoneNumberUiState: UiState<String> = .idle
        @Published public private(set) var otpButtonUiState: OTPButtonUiState = .disabled(0)
        @Published public private(set) var otpFieldUiState: OTPFieldUiState = .hidden
        
        @Published public private(set) var otpButtonCount = 0
        
        var continueButtonDisabled: Bool {
            if case .success = firstnameUiState,
               case .success = lastnameUiState,
               case .success = phoneNumberUiState,
               case .success = otpButtonUiState {
                return false
            }
            
            return true
        }
        
        func otpFail() {
            self.setOtpFieldUiState(.hidden)
            self.setOtpButtonUiState(.valid(otpButtonCount))
        }
        
        func otpSuccess() {
            self.setOtpFieldUiState(.hidden)
            self.setOtpButtonUiState(.success)
        }
        
        func setOtpButtonUiState(_ state: OTPButtonUiState) {
            self.otpButtonUiState = state
        }
        
        func setOtpFieldUiState(_ state: OTPFieldUiState) {
            self.otpFieldUiState = state
        }
        
        func sendOtp(_ phonenumber: String) {
            if case .valid = otpButtonUiState {
                self.otpButtonCount += 1
                self.setOtpButtonUiState(.disabled(otpButtonCount))
                self.otpFieldUiState = .displayed
                #warning("send otp here")
                
            } else {
                self.phoneNumberUiState = .failed("phone should contain 10 characters")
                return
            }
        }
        
        func setFirstnameUiState(_ name: String) {
            if name.regexChecker(with: .name) {
                self.firstnameUiState = .success("firstname is correct")
            } else {
                self.firstnameUiState = .failed("firstname format is wrong")
            }
        }
        
        func setLastnameUiState(_ name: String) {
            if name.regexChecker(with: .name) {
                self.lastnameUiState = .success("lastname in correct format")
            } else {
                self.lastnameUiState = .failed("lastname format is wrong")
            }
        }
        
        func validatePhoneFormat(_ number: String) {
            if number.regexChecker(with: .phone) {
                self.phoneNumberUiState = .success("phone in correct format")
                self.otpButtonUiState = .valid(0)
            } else {
                self.phoneNumberUiState = .failed("phone should contain 10 characters")
                self.otpButtonUiState = .disabled(0)
            }
        }
        
        func continueSignUp(firstname: String, lastname: String, province: Province, phoneNumber: String, success: @escaping (User, Bool) -> Void) {
            if !continueButtonDisabled {
                NavigationCoordinator.pushScreen(SignUpView(firstname: firstname, lastname: lastname, province: province, phonenumber: phoneNumber, success: success))
            }
        }
    }
}
