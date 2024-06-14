import SwiftUI

struct DropdownFieldView: View {
    let prompt: String
    let dropDownOptions: [ String ]
    let isLoading: Bool?
    
    @Binding var selectedItemIndex: Int?
    @State var isFocused = false
    
    var body: some View {
            VStack{
                HStack{
                    Text(selectedItemIndex == nil ? prompt : dropDownOptions[selectedItemIndex!])
                        .foregroundStyle(selectedItemIndex == nil ? .gray : .black)
                    Spacer()
                    Image(systemName: "chevron.down").foregroundColor(.gray).rotationEffect(.degrees(isFocused ? 180 : 0))
                }.padding(.horizontal, 16.0).padding(.vertical, 13.5)
                    .background(
                        Color.white
                    ).onTapGesture {
                        withAnimation(.snappy) {
                            isFocused.toggle()
                        }
                    }
                
                if isFocused{
                    if isLoading == true{
                        Text("Loading...").foregroundStyle(.black)
                    }else{
                        ScrollView(.vertical){
                            ForEach(dropDownOptions.indices, id: \.self) { index in
                                HStack{
                                    Text(dropDownOptions[index]).foregroundStyle(index == selectedItemIndex ? Color.black : Color.gray)
                                    Spacer()
                                    if index == selectedItemIndex{
                                        Image(systemName: "checkmark").foregroundStyle(Color.black)
                                    }
                                }.onTapGesture {
                                    withAnimation(.snappy) {
                                        selectedItemIndex = index
                                        isFocused.toggle()
                                    }
                                }.padding(.horizontal, 16.0)
                                    .padding(.vertical, 13.5)
                                    .background(
                                    index==selectedItemIndex ? Color(hex: "#A2D5FF") : Color.white
                                )
                            }
                        }.frame(height: 150)
                    }
                }
            }.background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: "#D1D1D1"), lineWidth: 1.5)
                )
                
        
    }
}

#Preview {
    DropdownFieldView(prompt: "Projects", dropDownOptions: ["Option-1", "Option-2", "Option-3", "Option-4", "Option-5",], isLoading: false, selectedItemIndex: .constant(nil))
}
