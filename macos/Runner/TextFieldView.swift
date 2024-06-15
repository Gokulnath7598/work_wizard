import SwiftUI

struct TextFieldView: View {
    @Binding var value: String
    let placeHolder: String
    
    var body: some View {
        TextField(placeHolder, text: $value).onChange(of: value) { newValue in
                    value = newValue
        }
        .placeholder(placeholder: placeHolder, placeholderColor: .gray, textColor: .black, text: $value)
        .padding(.horizontal, 16).padding(.vertical, 13.5).background(.white).cornerRadius(7).overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(hex: "#D1D1D1"), lineWidth: 1.5)
        )
    }
}

#Preview {
    TextFieldView(value: .constant(""), placeHolder: "Task")
}
