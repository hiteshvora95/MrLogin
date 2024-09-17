//
//  MrButton.swift
//  MrLogin
//
//  Created by apple on 17/09/24.
//

import SwiftUI

struct MrButton: View {
    let title: String
    let action: () -> Void
    let backgroundColor: Color
    let textColor: Color
    let cornerRadius: CGFloat

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(textColor)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
        }
        .shadow(radius: 5)
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}

#Preview {
    MrButton(title: "Click Me", action: {}, backgroundColor: .purple, textColor: .white, cornerRadius: 10)
}
