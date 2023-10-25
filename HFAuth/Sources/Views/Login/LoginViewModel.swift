//
//  LoginViewModel.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 13/10/2023.
//

import Foundation
import HFNavigation
import HFCoreUI
import FirebaseAuth

extension LoginView {
    class Model: ObservableObject {
        
        @Published public var emailUiState: UiState<String> = .idle
        @Published public var passwordUiState: UiState<String> = .idle
        
        public var buttonDisabled: Bool {
            if case .success = emailUiState, case .success = passwordUiState {
                return false
            }
            
            return true
        }
        
        func checkEmail(_ email: String) {
            self.emailUiState = .loading
            if email.regexChecker(with: .email) {
                self.emailUiState = .success("email is valide")
                return
            }
            
            self.emailUiState = .failed("email is not valide")
        }
        
        func checkPassword(_ password: String) {
            self.passwordUiState = .loading
            
            if password.regexChecker(with: .password) {
                self.passwordUiState = .success("password is valid")
                return
            }
            
            self.emailUiState = .failed("password is not valid")
        }
        
        func login(email: String, password: String, success: @escaping (User, Bool) -> Void) {
            Task {
                do {
                    
                    success(try await FirebaseAuth.shared.signIn(email: email, password: password), false)
                } catch {
                    self.emailUiState = .failed(error.localizedDescription)
                    self.passwordUiState = .failed(error.localizedDescription)
                }
            }
        }
        
        func resetPassword(email: String) {
            Task {
                do {
                    try await FirebaseAuth.shared.resetPassword(email: email)
                } catch {
                    self.emailUiState = .failed(error.localizedDescription)
                }
            }
        }
        
        func signup(success: @escaping (User, Bool) -> Void) {
            NavigationCoordinator.pushScreen(SignUpInfoView(success: success))
        }
    }
}
