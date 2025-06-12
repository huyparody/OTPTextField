//
//  ContentView.swift
//  OTPTextField-Example
//
//  Created by Huy Trinh Duc on 12/6/25.
//

import SwiftUI
import OTPTextField

struct ContentView: View {
    
    @State private var text = ""
    @State private var typingState: TypingState = .typing
    @State private var selectedStyle: OTPTextFieldStyle = .underlined
    @State private var simulateInvalidOTP = false
    
    var body: some View {
        VStack(spacing: 24) {
            Picker("Style", selection: $selectedStyle) {
                ForEach(OTPTextFieldStyle.allCases) { style in
                    Text(style.rawValue.capitalized).tag(style)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            OTPTextField(
                otpMaxDigit: 6,
                style: selectedStyle,
                options: .default,
                text: $text,
                typingState: $typingState,
                onComplete: {
                    print("Trigger validate otp")
                }
            )
            .padding(.horizontal)
            
            Toggle("Simulate OTP invalid", isOn: $simulateInvalidOTP)
                .padding()
                .onChange(of: simulateInvalidOTP) { isOn in
                    if isOn {
                        text = (0..<6).map { _ in "\(Int.random(in: 0...9))" }.joined()
                        typingState = .invalid
                    } else {
                        text = ""
                        typingState = .typing
                    }
                }
        }
        .padding(.vertical)
    }
}

#Preview {
    ContentView()
}
