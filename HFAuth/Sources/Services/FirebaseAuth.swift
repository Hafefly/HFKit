//
//  FirebaseAuth.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 13/10/2023.
//

import Foundation
import FirebaseAuth

final class FirebaseAuth {
    static let shared = FirebaseAuth()
    
    private init() { }
    
    public func getUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    public func getUser<T: HFUser>() throws -> T {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        return T(user: user)
    }
    
    @discardableResult
    public func signIn<T: HFUser>(email: String, password: String) async throws -> T {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        
        return T(user: authResult.user)
    }
    
    @discardableResult
    public func createUser<T: HFUser>(email: String, password: String) async throws -> T {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        return T(user: authResult.user)
    }
    
    public func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    public func loggout() throws {
        try Auth.auth().signOut()
    }
}
