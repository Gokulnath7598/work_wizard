import SwiftUI

struct TextFieldView: View {
    @Binding var value: String
    let placeHolder: String

    var body: some View {
        TextField(placeHolder, text: $value, onEditingChanged: { _ in
        }, onCommit: {
            self.value = self.value.trimmingCharacters(in: .whitespacesAndNewlines)
        })
        .textFieldStyle(.plain)
        .placeholder(placeholder: placeHolder, placeholderColor: .gray, textColor: .black, text: $value)
        .padding(.horizontal, 16)
        .padding(.vertical, 13.5)
        .background(Color.white)
        .cornerRadius(7)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(hex: "#D1D1D1"), lineWidth: 1.5)
        )
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(value: .constant(""), placeHolder: "Task")
    }
}
