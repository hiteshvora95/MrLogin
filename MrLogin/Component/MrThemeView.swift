//
//  MrThemeView.swift
//  MrLogin
//
//  Created by apple on 17/09/24.
//

import SwiftUI

struct Theme {
    static let backgroundColor: Color = Color.myColor1
}

struct MrThemeView: ViewModifier {
    let color: Color
        
    func body(content: Content) -> some View {
        content
            .background(color)
//            .edgesIgnoringSafeArea(.all)
    }
}

extension View {
    func themeBackground(color: Color = Color.white) -> some View {
        self.modifier(MrThemeView(color: color))
    }
}
