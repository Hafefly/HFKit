//
//  SignUpInfoView.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 16/10/2023.
//

import SwiftUI
import HFCoreUI
import FirebaseAuth

struct SignUpInfoView: View {
    @StateObject private var model = Model()
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var phonenumber: String = ""
    
    @State private var province: Province = .Algiers
    
    let success: (User, Bool) -> Void
    
    init(success: @escaping (User, Bool) -> Void) {
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
            VStack(spacing: 12){
                HStack {
                    TextField("firstname".localized, text: $firstname)
                        .placeholder(when: firstname.isEmpty) {
                            Text("firstname")
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .textFieldStyle(HFTextFieldStyle(model.firstnameUiState))
                        .onChange(of: firstname, perform: model.setFirstnameUiState)
                    TextField("lastname".localized, text: $lastname)
                        .placeholder(when: lastname.isEmpty) {
                            Text("lastname")
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .textFieldStyle(HFTextFieldStyle(model.lastnameUiState))
                        .onChange(of: lastname, perform: model.setLastnameUiState)
                }
                
                Picker("province".localized, selection: $province) {
                    ForEach(Province.allCases, id: \.hashValue) {
                        Text($0.rawValue)
                            .font(.white, .medium, 18)
                            .padding()
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 56)
                .background(Color.primaryColor)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white, lineWidth: 3)
                )
                
                HStack{
                    TextField("phonenumber".localized, text: $phonenumber)
                        .placeholder(when: phonenumber.isEmpty) {
                            Text("phone number")
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .textFieldStyle(HFTextFieldStyle(model.phoneNumberUiState))
                        .onChange(of: phonenumber, perform: model.validatePhoneFormat)
                    
                    Button {
                        model.sendOtp(phonenumber)
                    } label: {
                        Text(model.otpButtonUiState.text)
                            .font(.white, .regular, 16)
                    }
                    .frame(width: 100)
                    .buttonStyle(HFButtonStyle(disabled: model.otpButtonUiState.disabled))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(model.otpButtonUiState == .success ? Color.green : Color.white, lineWidth: 3)
                    )
                }
            }
            
            OTPFieldView(phonenumber, success: model.otpSuccess, fail: model.otpFail)
            
            Spacer()
            Button {
                model.continueSignUp(firstname: firstname, lastname: lastname, province: province, phoneNumber: phonenumber, success: success)
            } label: {
                Text("continue".localized)
                    .font(.white, .semiBold, 18)
            }
            .buttonStyle(HFButtonStyle(disabled: model.continueButtonDisabled))
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
        .onTapGesture(perform: UIApplication.endEditing)
    }
}

struct SignUpInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpInfoView { user, isNew in
            //
        }
    }
}
