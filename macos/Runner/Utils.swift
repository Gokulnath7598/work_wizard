import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            let red = Double((hexNumber & 0xff0000) >> 16) / 255.0
            let green = Double((hexNumber & 0x00ff00) >> 8) / 255.0
            let blue = Double(hexNumber & 0x0000ff) / 255.0
            
            self.init(red: red, green: green, blue: blue)
            return
        }
        
        self.init(red: 0, green: 0, blue: 0) // Return black if invalid hex string
    }
}

struct PlaceholderColorModifier: ViewModifier {
    var placeholder: String
    var placeholderColor: Color
    var textColor: Color

    @Binding var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .padding(.leading, 5.0)
            }
            content
                .foregroundColor(textColor)
        }
    }
}

extension View {
    func placeholder(placeholder: String, placeholderColor: Color, textColor: Color, text: Binding<String>) -> some View {
        self.modifier(PlaceholderColorModifier(placeholder: placeholder, placeholderColor: placeholderColor, textColor: textColor, text: text))
    }
}

