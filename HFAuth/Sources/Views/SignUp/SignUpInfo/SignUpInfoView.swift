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
    @State private var otpCode: String = ""
    
    @State private var province: Province = .Algiers
    
    @FocusState private var activeField: OTPField?
    
    let success: (User, Bool) -> Void
    
    init(success: @escaping (User, Bool) -> Void) {
        self.success = success
    }

    private var otp: String {
        return model.otpFields.joined()
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
                        .onChange(of: lastname) { newValue in
                            model.setFirstnameUiState(model.validateName(newValue))
                        }
                    TextField("lastname".localized, text: $lastname)
                        .placeholder(when: lastname.isEmpty) {
                            Text("lastname")
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .textFieldStyle(HFTextFieldStyle(model.lastnameUiState))
                        .onChange(of: lastname) { newValue in
                            model.setLastnameUiState(model.validateName(newValue))
                        }
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
                        .onChange(of: phonenumber) { newValue in
                            model.validatePhoneFormat(newValue)
                        }
                    
                    Button {
                        model.sendOtp(phonenumber: phonenumber)
                    } label: {
                        Text(model.otpButtonText)
                            .font(.white, .regular, 16)
                    }
                    .frame(width: 100, height: 56)
                    .background(model.otpButtonDisabledd() ? Color.primaryColor : Color.hfOrange)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 3)
                    )
                    .disabled(model.otpButtonDisabledd())
                }
            }
            
            OTPField()
                .onChange(of: model.otpFields) { newValue in
                    if model.handleAutoFill(value: newValue, codeLength: 6) {
                        activeField = nil
                    } else {
                        model.updateActiveField(value: newValue, codeLength: 6, activeField: activeField) { newActiveField in
                            activeField = newActiveField
                        }
                        if newValue.joined().count == 6 {
                            for item in newValue {
                                if item.count == 0 { return }
                            }
                            activeField = nil
                        }
                    }
                }
            
            Spacer()
            Button {
                model.checkInfo(firstname: firstname, lastname: lastname, province: province, phoneNumber: phonenumber, otpCode: otpCode, success: success)
            } label: {
                Text("continue".localized)
                    .font(.white, .semiBold, 18)
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
        .onTapGesture(perform: UIApplication.endEditing)
    }
    
    @ViewBuilder
    func OTPField() -> some View {
        VStack{
            HStack{
                ForEach(0 ..< 6, id: \.hashValue) { index in
                    ZStack{
                        TextField("", text: $model.otpFields[index])
                            .keyboardType(.numberPad)
                            .textContentType(.oneTimeCode)
                            .multilineTextAlignment(.center)
                            .focused($activeField, equals: model.activeStateForIndex(index: index))
                    }
                    .background(
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .frame(width: 44, height: 62)
                                .foregroundColor(.hfOrange.opacity(0.5))
                            
                            Rectangle()
                                .frame(width: 44, height: 5)
                                .foregroundColor(.white)
                        }
                            .cornerRadius(6))
                }
            }
            HStack{
                Text("daily_send_code".localized)
                    .font(.white, .regular, 14)
                Text("00:\(model.timeCounting / 1000)")
                    .font(.white, .bold, 14)
            }
            .onReceive(model.timer){ timer in
                model.timerCountdown(timer: timer)
            }
        }
    }
}

struct SignUpInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpInfoView { user, isNew in
            //
        }
    }
}
