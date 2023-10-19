//
//  LoginView.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 12/10/2023.
//

import SwiftUI
import HFCoreUI
import FirebaseAuth

struct LoginView<T: HFUser>: View {
    
    @StateObject private var model = Model()
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    let success: (T, Bool) -> Void
    
    init(success: @escaping (T, Bool) -> Void) {
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
                    .placeholder(when: email.isEmpty) {
                        Text("email")
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .textFieldStyle(HFTextFieldStyle(model.emailUiState))
                SecureField("password", text: $password)
                    .textFieldStyle(HFTextFieldStyle(model.passwordUiState))
                HStack{
                    Button {
                        model.resetPassword(email: email)
                    } label: {
                        Text("reset password")
                            .font(.white, .medium, 12)
                    }
                    .frame(width: 100)
                    .padding(8)
                    .background(Color.primaryColor)
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .stroke(Color.white, lineWidth: 1)
                    )
                    
                    Spacer()
                    
                    Button {
                        model.signup(success: success)
                    } label: {
                        Text("sign up")
                            .font(.white, .medium, 12)
                    }
                    .frame(width: 100)
                    .padding(8)
                    .background(Color.primaryColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .stroke(Color.white, lineWidth: 1)
                    )
                }
            }
            Separator("or")
            HStack(spacing: 64){
                ForEach(AuthProvider.allCases, id: \.hashValue) { provider in
                    Button {
                        //
                    } label: {
                        provider
                            .icon
                    }
                }
            }
            
            Spacer()
            
            Button {
                model.login(email: email, password: password, success: success)
            } label: {
                Text("Sign in")
                    .font(.white, .bold, 20)
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

struct LoginView_Previews: PreviewProvider {
    struct PreviewStruct: HFUser {
        init(user: User) {
            //
        }
    }
    static var previews: some View {
        
        LoginView<PreviewStruct> { user, isNew in
            //
        }
    }
}
