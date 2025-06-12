//
//  OTPTextFieldOptions.swift
//  OTPTextField
//
//  Created by Huy Trinh Duc on 12/6/25.
//

import Foundation
import SwiftUI

/// Indicates the current input state of the OTP text field.
public enum TypingState {
    case typing
    case invalid
}

/// Styles supported by the OTP field.
public enum OTPTextFieldStyle: String, CaseIterable, Identifiable {
    case roundedBorder
    case underlined
    
    public var id: String {
        rawValue
    }
}

/// Configuration options for `OTPTextField`.
public struct OTPTextFieldOptions {
    
    // MARK: - Border
    
    /// The color of the border in normal state.
    public var borderColor = Color.gray
    
    /// The corner radius for rounded border style.
    public var borderCornerRadius: CGFloat = 10
    
    /// The width of the border.
    public var borderWidth: CGFloat = 1.2
    
    // MARK: - Fill
    
    /// The fill color for the background of each OTP field.
    public var fillColor = Color.clear
    
    // MARK: - Underline
    
    /// The height of the underline for underlined style.
    public var underlineHeight: CGFloat = 1
    
    // MARK: - Active & Invalid Colors
    
    /// The border color when the field is active.
    public var activeBorderColor = Color.blue
    
    /// The border color when the OTP is marked as invalid.
    public var invalidColor = Color.red
    
    // MARK: - TextField Dimensions
    
    /// The height of each OTP text field box.
    public var textFieldHeight: CGFloat = 50
    
    // MARK: - Text
    
    /// The font used for each OTP character.
    public var textFont: Font
    
    /// The color of the text displayed.
    public var textColor: Color
    
    // MARK: - Spacing
    
    /// Spacing between underlined fields.
    public var underlineSpacing: CGFloat = 16
    
    /// Spacing between rounded corner fields.
    public var roundedCornerSpacing: CGFloat = 6
    
    /// Default configuration.
    @MainActor public static let `default` = OTPTextFieldOptions(
        textFont: .system(size: 20, weight: .medium),
        textColor: .primary
    )
    
    /// Public initializer to create a custom configuration.
    public init(
        borderColor: Color = .gray,
        borderCornerRadius: CGFloat = 10,
        borderWidth: CGFloat = 1.2,
        fillColor: Color = .clear,
        underlineHeight: CGFloat = 1,
        activeBorderColor: Color = .blue,
        invalidColor: Color = .red,
        textFieldHeight: CGFloat = 50,
        textFont: Font,
        textColor: Color,
        underlineSpacing: CGFloat = 16,
        roundedCornerSpacing: CGFloat = 6,
        underlineWidth: CGFloat = 40,
        roundedCornerWidth: CGFloat = 50
    ) {
        self.borderColor = borderColor
        self.borderCornerRadius = borderCornerRadius
        self.borderWidth = borderWidth
        self.fillColor = fillColor
        self.underlineHeight = underlineHeight
        self.activeBorderColor = activeBorderColor
        self.invalidColor = invalidColor
        self.textFieldHeight = textFieldHeight
        self.textFont = textFont
        self.textColor = textColor
        self.underlineSpacing = underlineSpacing
        self.roundedCornerSpacing = roundedCornerSpacing
    }
}
