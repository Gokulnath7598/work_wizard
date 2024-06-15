import SwiftUI

struct NumericFieldView: View {
    let placeholder: String
    @Binding var value: String
    
    var body: some View {
        TextField("Enter number", text: $value)
            .textFieldStyle(.plain)
            .placeholder(placeholder: placeholder, placeholderColor: .gray, textColor: .black, text: $value)
            .padding(.horizontal, 16).padding(.vertical, 13.5).background(Color.white).cornerRadius(7).overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(hex: "#D1D1D1"), lineWidth: 1.5)
            ).onReceive(value.publisher.collect()) {
                let filtered = $0.filter { "0123456789.".contains($0) }
                let decimalCount = filtered.filter { $0 == "." }.count
                if decimalCount <= 1 {
                    self.value = String(filtered)
                } else {
                    let truncated = String(filtered.prefix(while: { $0 != "." }))
                    self.value = truncated + "." + String(filtered.dropFirst(truncated.count + 1).filter { $0 != "." })
                }
            }
    }
    
}

extension NumberFormatter {
    static var doubleFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 10
        formatter.allowsFloats = false
        formatter.usesGroupingSeparator = false
        return formatter
    }
}
