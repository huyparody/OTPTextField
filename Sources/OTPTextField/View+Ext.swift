//
//  View+Ext.swift
//  OTPTextField
//
//  Created by Huy Trinh Duc on 12/6/25.
//

import Foundation
import SwiftUI

struct BlurReplaceTransition: ViewModifier {
    @ViewBuilder func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .transition(.blurReplace)
        }
        else {
            content
                .transition(.opacity)
        }
    }
}

struct PhaseAnimatorViewModifier: ViewModifier {
    
    var trigger: Bool
    
    func body(content: Content) -> some View {
        if #available(iOS 17, *) {
            content
                .phaseAnimator([0, 10, -10, 10, -5, 5, 0], trigger: trigger, content: { content, offset in
                    content
                        .offset(x: offset)
                }, animation: { _ in
                        .linear(duration: 0.06)
                })
        }
        else {
            content
        }
    }
}

extension View {
    func blurReplaceTransition() -> some View {
        modifier(BlurReplaceTransition())
    }
    
    func phaseAnimator(trigger: Bool) -> some View {
        modifier(PhaseAnimatorViewModifier(trigger: trigger))
    }
}
