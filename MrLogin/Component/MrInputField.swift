//
//  MrInputField.swift
//  MrLogin
//
//  Created by apple on 17/09/24.
//

import SwiftUI

extension Color {
    static let myColor1 = Color("Color1")
    static let myColor2 = Color("Color2")
}

struct MrInputField: View {
    var textCase: Text.Case?
    let leftImage: String
    let placeholder: String
    var keyboardType: UIKeyboardType?
    var textContentType: UITextContentType?
    var textInputAutoCapital: TextInputAutocapitalization?
    var isSecureField: Bool? = false
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: leftImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.color2)
                
                if isSecureField ?? false {
                    SecureField(placeholder, text: $text)
                        .textContentType(textContentType != nil ? textContentType : .none)
                } else {
                    TextField(placeholder, text: $text, onEditingChanged: { _ in
                        text = setTextCase(text: text)
                    })
                    .keyboardType(keyboardType != nil ? keyboardType! : .default)
                    .textContentType(textContentType != nil ? textContentType : .none)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(textInputAutoCapital != nil ? textInputAutoCapital : .none)
                    .onChange(of: text) { newValue in
                        text = setTextCase(text: text)
                    }
                }
            }
            
            Divider()
                .background(Color.color2)
                .frame(height: 2)
        }
    }
}

#Preview {
    MrInputField(leftImage: "person", placeholder: "Name", isSecureField: false, text: .constant(""))
}

extension MrInputField {
    func setTextCase(text: String) -> String {
        if let textCase = textCase {
            switch textCase {
            case .lowercase:
                return text.lowercased()
            case .uppercase:
                return text.uppercased()
            @unknown default:
                return text
            }
        }
        return text
    }
}
