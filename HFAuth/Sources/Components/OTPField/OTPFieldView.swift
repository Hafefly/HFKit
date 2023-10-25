//
//  File.swift
//  
//
//  Created by Samy Mehdid on 25/10/2023.
//

import SwiftUI

struct OTPFieldView: View {
    
    @StateObject public var model = Model()
    
    private let phoneNumber: String
    private let success: () -> Void
    private let fail: () -> Void
    
    @FocusState private var activeField: OTPField?
    
    private var otpCode: String {
        return model.otpFields.joined()
    }
    
    init(_ phoneNumber: String, success: @escaping () -> Void, fail: @escaping () -> Void) {
        self.phoneNumber = phoneNumber
        self.success = success
        self.fail = fail
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24){
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
                        .cornerRadius(6)
                    )
                }
            }
            if model.timeCounting > 0 {
                HStack{
                    Text("resend code in: ")
                        .font(.white, .regular, 14)
                    Text("00:\(model.timeCounting / 1000)")
                        .font(.white, .bold, 14)
                }
                .onReceive(model.timer){ timer in
                    model.timerCountdown(timer: timer)
                }
            }
        }
        .onAppear(perform: model.startTimer)
        .onDisappear(perform: model.endTimer)
        .onChange(of: model.otpFields) { newValue in
            if model.handleAutoFill(value: newValue, codeLength: 6) {
                activeField = nil
                model.verifyOtp(for: phoneNumber, success: success)
            } else {
                model.updateActiveField(value: newValue, codeLength: 6, activeField: activeField) { newActiveField in
                    activeField = newActiveField
                }
                if newValue.joined().count == 6 {
                    for item in newValue {
                        if item.count == 0 { return }
                    }
                    activeField = nil
                    model.verifyOtp(for: phoneNumber, success: success)
                }
            }
        }
    }
}