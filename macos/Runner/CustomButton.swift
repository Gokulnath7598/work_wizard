import SwiftUI

struct CustomButton: View {
    let buttonThemeColor: Color
    let label: String
    let isFilled: Bool?
    let isLoading: Bool?
    let onPressAction: () -> Void

    var body: some View {
        Button(action: onPressAction) {
            if isLoading == true {
                LottieView(filename: "time_loader_50.json")
                    .frame(maxWidth: .infinity, minHeight: 30)
            } else {
                Text(label)
                    .foregroundColor(isFilled == true ? Color.white : buttonThemeColor)
                    .padding(.vertical, 13.5)
                    .frame(maxWidth: .infinity)
            }
        }
        .background(isFilled != true ? Color.white : buttonThemeColor)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(buttonThemeColor, lineWidth: 1.5)
        )
    }
}

#Preview {
    CustomButton(
        buttonThemeColor: Color(hex: "#00A4EF"), label: "In Progress", isFilled: false, isLoading: false
    ) {}
}
