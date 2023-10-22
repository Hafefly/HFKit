//
//  SignUpView.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 16/10/2023.
//

import SwiftUI
import HFCoreUI
import FirebaseAuth

struct SignUpView: View {
    
    let firstname: String
    let lastname: String
    let province: Province
    let phonenumber: String
    
    @StateObject private var model = Model()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rePassword: String = ""
    
    let success: (User, Bool) -> Void
    
    init(firstname: String, lastname: String, province: Province, phonenumber: String, success: @escaping (User, Bool) -> Void) {
        self.firstname = firstname
        self.lastname = lastname
        self.province = province
        self.phonenumber = phonenumber
        
        self.success = success
    }
    
    var body: some View {
        VStack(spacing: 32){
            Spacer()
            Image("logo_hafefly_white")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 32)
            Spacer()
            VStack(spacing: 16){
                
                TextField("email", text: $email)
                    .textFieldStyle(HFTextFieldStyle(model.emailUiState))
                
                SecureField("password", text: $password)
                    .textFieldStyle(HFTextFieldStyle(model.passwordUiState))
                
                SecureField("rePassword", text: $rePassword)
                    .textFieldStyle(HFTextFieldStyle(model.rePasswordUiState))
            }
            
            Spacer()
            
            Button("Sign up") {
                model.signUp(firstname: firstname, lastname: lastname, province: province, phonenumber: phonenumber, email: email, password: password, success: success)
            }
            .buttonStyle(HFButtonStyle())
        }
        .padding(16)
        .background(
            ZStack{
                Image("BackgroundImage")
                    .blur(radius: 10)
                LinearGradient.hfGradient
            }
                .ImagePattern()
        )
    }
}
