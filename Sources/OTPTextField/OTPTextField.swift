//
//  OTPTextField.swift
//  OTPTextField
//
//  Created by Huy Trinh Duc on 12/6/25.
//

import SwiftUI

/// A customizable One-Time Password (OTP) input field.
/// - Supports underlined and rounded border styles.
/// - Animates when input becomes invalid based on external API logic.
public struct OTPTextField: View {
    
    /// Maximum number of digits for the OTP.
    public var otpMaxDigit: Int
    
    /// Visual style of the text field (`.underlined` or `.roundedBorder`).
    public var style: OTPTextFieldStyle
    
    /// Optional configuration options (colors, spacing, font...).
    public var options: OTPTextFieldOptions = .default
    
    /// Binding to the text entered by the user.
    @Binding public var text: String
    
    /// Binding to the typing state, should be updated externally when validation fails.
    @Binding public var typingState: TypingState
    
    /// Called when the user has finished entering all digits of the OTP.
    ///
    /// Use this closure to trigger verification logic, such as calling an API to validate the OTP.
    public var onComplete: (() -> ())
    
    @FocusState private var isFocus: Bool
    @State private var invalidTrigger: Bool = false
    
    public init(
        otpMaxDigit: Int,
        style: OTPTextFieldStyle,
        options: OTPTextFieldOptions = .default,
        text: Binding<String>,
        typingState: Binding<TypingState>,
        onComplete: @escaping (()->())
    ) {
        self.otpMaxDigit = otpMaxDigit
        self.style = style
        self.options = options
        self._text = text
        self._typingState = typingState
        self.onComplete = onComplete
    }
    
    public var body: some View {
        HStack(spacing: textFieldSpacing) {
            ForEach(0..<otpMaxDigit, id: \.self) { index in
                characterField(index: index)
            }
        }
        .animation(.easeInOut, value: text)
        .animation(.easeInOut, value: isFocus)
        .phaseAnimator(trigger: invalidTrigger) // Custom invalid animation
        .background {
            // Hidden TextField capturing all input
            TextField("", text: $text)
                .focused($isFocus)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .mask(alignment: .trailing) {
                    Rectangle().frame(width: 1, height: 1).opacity(0.01)
                }
                .allowsHitTesting(false)
        }
        .contentShape(.rect)
        .onAppear {
            isFocus = true
        }
        .onTapGesture {
            isFocus = true
        }
        .onChange(of: text) { newValue in
            text = String(newValue.prefix(otpMaxDigit))
            
            if text.count == otpMaxDigit {
                onComplete()
            }
        }
        .onChange(of: typingState) { newValue in
            if newValue == .invalid {
                invalidTrigger.toggle()
            }
        }
    }
    
    /// Returns a character box view at a specific index.
    @ViewBuilder private func characterField(index: Int) -> some View {
        Group {
            switch style {
            case .roundedBorder:
                RoundedRectangle(cornerRadius: options.borderCornerRadius)
                    .stroke(borderColor(index: index), lineWidth: options.borderWidth)
                    .overlay {
                        RoundedRectangle(cornerRadius: options.borderCornerRadius)
                            .fill(options.fillColor)
                    }
            case .underlined:
                Rectangle()
                    .fill(borderColor(index: index))
                    .frame(height: options.underlineHeight)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .frame(height: options.textFieldHeight)
        .overlay {
            let stringValue = string(index)
            if !stringValue.isEmpty {
                Text(stringValue)
                    .font(options.textFont)
                    .foregroundStyle(options.textColor)
                    .blurReplaceTransition()
            }
        }
    }
    
    /// Returns the character at the specified index in the OTP text.
    private func string(_ index: Int) -> String {
        guard text.count > index else { return "" }
        let stringIndex = text.index(text.startIndex, offsetBy: index)
        return String(text[stringIndex])
    }
    
    /// Determines the border color for the given field based on state.
    private func borderColor(index: Int) -> Color {
        switch typingState {
        case .typing:
            if text.count == index && isFocus {
                return options.activeBorderColor
            }
            return options.borderColor
        case .invalid:
            return options.invalidColor
        }
    }
    
    /// Spacing between each OTP character field.
    private var textFieldSpacing: CGFloat {
        switch style {
        case .roundedBorder:
            return options.roundedCornerSpacing
        case .underlined:
            return options.underlineSpacing
        }
    }
}
