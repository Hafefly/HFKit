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
