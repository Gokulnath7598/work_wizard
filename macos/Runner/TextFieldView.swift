// import SwiftUI
//
// struct TextFieldView: View {
//     @Binding var value: String
//     let placeHolder: String
//
//     var body: some View {
//         TextField(placeHolder, text: $value).foregroundColor(.black).onChange(of: value) { newValue in
//                     value = newValue
//         }.padding(.horizontal, 16).padding(.vertical, 13.5).background(Color.white).cornerRadius(7).overlay(
//             RoundedRectangle(cornerRadius: 10)
//                 .stroke(Color(hex: "#D1D1D1"), lineWidth: 1.5)
//         )
//     }
// }
//
// #Preview {
//     TextFieldView(value: .constant(""), placeHolder: "Task")
// }

import SwiftUI

struct TextFieldView: View {
    @Binding var value: String
    let placeHolder: String

    var body: some View {
        TextField(placeHolder, text: $value, onEditingChanged: { _ in
            // Handle editing changed event if needed
        }, onCommit: {
            // Handle on commit event if needed
            // Manually update the binding value
            self.value = self.value.trimmingCharacters(in: .whitespacesAndNewlines)
        })
        .foregroundColor(.black)
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
