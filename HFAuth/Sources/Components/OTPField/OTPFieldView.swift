//
//  File.swift
//  
//
//  Created by Samy Mehdid on 25/10/2023.
//

import SwiftUI
import HFCoreUI

struct OTPFieldView: View {
    
    @StateObject public var model = Model()
    
    private let phoneNumber: String
    
    @Binding public var otpFieldUiState: OTPFieldUiState
    
    private let completion: (Int?, Error?) -> Void
    
    @FocusState private var activeField: OTPField?
    
    private var otpCode: String {
        return model.otpFields.joined()
    }
    
    init(_ phoneNumber: String, otpFieldUiState: Binding<OTPFieldUiState>, completion: @escaping (Int?, Error?) -> Void) {
        self.phoneNumber = phoneNumber
        self._otpFieldUiState = otpFieldUiState
        self.completion = completion
    }
    
    var body: some View {
        switch otpFieldUiState {
        case .hidden, .success:
            EmptyView()
        case .displayed:
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
                    model.verifyOtp(for: phoneNumber, completion: completion)
                } else {
                    model.updateActiveField(value: newValue, codeLength: 6, activeField: activeField) { newActiveField in
                        activeField = newActiveField
                    }
                    if newValue.joined().count == 6 {
                        for item in newValue {
                            if item.count == 0 { return }
                        }
                        activeField = nil
                        model.verifyOtp(for: phoneNumber, completion: completion)
                    }
                }
            }
        case .loading:
            LoadingView()
                .frame(width: 24, height: 24)
        }
    }
}
