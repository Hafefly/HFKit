//
//  SignUpViewModel.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 17/10/2023.
//

import Foundation
import HFNavigation
import HFCoreUI

extension SignUpView {
    class Model: ObservableObject {
        
        @Published public private(set) var emailUiState: UiState<String> = .idle
        @Published public private(set) var passwordUiState: UiState<String> = .idle
        @Published public private(set) var rePasswordUiState: UiState<String> = .idle
        
        func signUp(firstname: String, lastname: String, province: Province, phonenumber: String, email: String, password: String, success: @escaping (T, Bool) -> Void) {
            
            DispatchQueue.main.async {
                Task {
                    do {
                        success(try await FirebaseAuth.shared.createUser(email: email, password: password), true)
                        
//                        barber.firstname = firstname
//                        barber.lastname = lastname
//                        barber.email = email
//                        barber.experience = 0
//                        barber.haircutsDone = 0
//                        barber.isAvailableToHome = true
//                        barber.phoneNumber = phonenumber
//                        barber.province = province.rawValue
//                        barber.verified = false
//                        
//                        try BarberRepo.shared.createBarber(barber)
//                        
//                        NavigationCoordinator.shared.switchStartPoint(MainView(tab: .home))
                        
                    } catch {
                        self.emailUiState = .failed(error.localizedDescription)
                        self.passwordUiState = .failed(error.localizedDescription)
                        self.rePasswordUiState = .failed(error.localizedDescription)
                    }
                }
            }
        }
        
        @discardableResult
        func validateEmail(_ email: String) -> Bool {
            let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
            
            
            let result = email.regexChecker(with: emailRegex)
            if result {
                self.emailUiState = .success("email in correct format")
            } else {
                self.emailUiState = .failed("email must be of format: example@gmail.com")
            }
            
            return result
        }
        
        @discardableResult
        func validatePassword(_ password: String) -> Bool {
            let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
            
            
            let result = password.regexChecker(with: passwordRegex)
            if result {
                self.passwordUiState = .success("password in correct format")
            } else {
                self.passwordUiState = .failed("password must contain at least 8 characters, one uppercase, one lowercase, a number and a special character!")
            }
            return result
        }
        
        @discardableResult
        func passwordsCheck(password: String, rePassword: String) -> Bool {
            guard !rePassword.isEmpty else { return false }
            
            if rePassword == password {
                self.rePasswordUiState = .success("passwords match")
                return true
            } else {
                self.rePasswordUiState = .failed("passwords do not match")
                return false
            }
        }
        
        func validateEnteries(firstname: String, lastname: String, province: Province, phoneNumber: String, email: String, password: String, rePassword: String, success: @escaping (T, Bool) -> Void) {
            if validateEmail(email),
               validatePassword(password),
               passwordsCheck(password: password, rePassword: rePassword) {
                signUp(firstname: firstname, lastname: lastname, province: province, phonenumber: phoneNumber, email: email, password: password, success: success)
            }
        }
    }
}
