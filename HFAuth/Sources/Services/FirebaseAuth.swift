//
//  FirebaseAuth.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 13/10/2023.
//

import Foundation
import FirebaseAuth

final public class FirebaseAuth {
    static public let shared = FirebaseAuth()
    
    private init() { }
    
    public func getUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    public func getUser() throws -> User {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        return user
    }
    
    @discardableResult
    public func signIn(email: String, password: String) async throws -> User {
        
        return try await Auth.auth().signIn(withEmail: email, password: password).user
    }
    
    @discardableResult
    public func createUser(email: String, password: String) async throws -> User {
        
        return try await Auth.auth().createUser(withEmail: email, password: password).user
    }
    
    public func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    public func loggout() throws {
        try Auth.auth().signOut()
    }
}
