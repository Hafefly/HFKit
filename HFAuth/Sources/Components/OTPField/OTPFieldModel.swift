//
//  File.swift
//  
//
//  Created by Samy Mehdid on 25/10/2023.
//

import Foundation
import Combine

extension OTPFieldView {
    class Model: ObservableObject {
        
        @Published public private(set) var timeCounting = 60000
        
        @Published public var otpFields: [String] = Array(repeating: "", count: 6)
        
        let timer = Timer.publish(every: 1, on: .main, in: .common)
        
        func startTimer() {
            self.timer.connect()
        }
        
        func endTimer() {
            self.timer.connect().cancel()
        }
        
        func verifyOtp(for phonenumber: String, completion: @escaping (Int?, Error?) -> Void) {
            
            #warning("verify otp here")
            completion(200, nil)
        }
        
        func updateActiveField(value: [String], codeLength: Int, activeField: OTPField?, nextActiveField: @escaping (OTPField?) -> Void) {
            for index in 1 ... (codeLength - 1){
                if value[index].isEmpty && !value[index - 1].isEmpty {
                    nextActiveField(activeStateForIndex(index: index - 1))
                }
            }
            
            for index in 0 ..< (codeLength - 1){
                if value[index].count == 1 && activeStateForIndex(index: index) == activeField {
                    nextActiveField(activeStateForIndex(index: index + 1))
                }
            }
            for index in 0 ..< codeLength {
                if value[index].count > 1 {
                    otpFields[index] = String(value[index].last!)
                }
            }
        }
        
        func activeStateForIndex(index: Int) -> OTPField {
            switch index {
            case 0: return .field1
            case 1: return .field2
            case 2: return .field3
            case 3: return .field4
            case 4: return .field5
            default: return .field6
            }
        }
        
        func handleAutoFill(value: [String], codeLength: Int) -> Bool {
            for item in value {
                if item.count == codeLength {
                    for i in 0...(codeLength - 1) {
                        otpFields[i] = String(Array(item)[i])
                    }
                    return true
                }
            }
            if otpFields.joined().count == codeLength { return true }
            return false
        }
        
        func timerCountdown(timer: Publishers.Autoconnect<Timer.TimerPublisher>.Output) {
            if timeCounting > 0 {
                timeCounting -= 1000
            } else {
                self.timer.connect().cancel()
            }
        }
    }
}
