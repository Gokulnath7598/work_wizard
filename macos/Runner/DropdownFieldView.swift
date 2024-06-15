import SwiftUI

struct DropdownFieldView: View {
    let prompt: String
    let dropDownOptions: [String]
    let isLoading: Bool?

    @Binding var selectedItemIndex: Int?
    @State private var isFocused = false

    var body: some View {
        VStack {
            dropdownHeader
                .padding(.horizontal, 16.0)
                .padding(.vertical, 13.5)
                .background(Color.white)
                .onTapGesture {
                    withAnimation(.snappy) {
                        isFocused.toggle()
                    }
                }

            if isFocused {
                dropdownContent
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(hex: "#D1D1D1"), lineWidth: 1.5)
        )
    }

    private var dropdownHeader: some View {
        HStack {
            Text(selectedItemIndex == nil ? prompt : dropDownOptions[selectedItemIndex!])
                .foregroundColor(selectedItemIndex == nil ? .gray : .black)
            Spacer()
            Text("▼")
                .foregroundColor(.gray)
                .rotationEffect(.degrees(isFocused ? 180 : 0))
        }
    }

    @ViewBuilder
    private var dropdownContent: some View {
        if isLoading == true {
            LottieView(filename: "time_loader_blue_50.json")
                .frame(maxWidth: .infinity, minHeight: 30)
        } else {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ForEach(dropDownOptions.indices, id: \.self) { index in
                        dropdownItem(for: index)
                    }
                }
            }
            .frame(height: 150)
        }
    }

    private func dropdownItem(for index: Int) -> some View {
        HStack {
            Text(dropDownOptions[index])
                .foregroundColor(index == selectedItemIndex ? .black : .gray)
            Spacer()
            if index == selectedItemIndex {
                checkmarkImage
            }
        }
        .onTapGesture {
            withAnimation(.snappy) {
                selectedItemIndex = index
                isFocused.toggle()
            }
        }
        .padding(.horizontal, 16.0)
        .padding(.vertical, 13.5)
        .background(index == selectedItemIndex ? Color(hex: "#A2D5FF") : Color.white)
    }

    @ViewBuilder
    private var checkmarkImage: some View {
            Image(nsImage: NSImage(named: "NSMenuCheckmark")!)
                .foregroundColor(.black)
    }
}

#Preview {
    DropdownFieldView(prompt: "Projects", dropDownOptions: ["Option-1", "Option-2", "Option-3", "Option-4", "Option-5"], isLoading: false, selectedItemIndex: .constant(nil))
}
