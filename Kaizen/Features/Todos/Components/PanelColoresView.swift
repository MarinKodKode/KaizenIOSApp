import SwiftUI

struct PanelColoresView: View {
    @State var colores: [ColorOptionModel] = [
        ColorOptionModel(color:.red),
        ColorOptionModel(color:.yellow),
        ColorOptionModel(color:.blue),
        ColorOptionModel(color:.green),
        ColorOptionModel(color:.pink),
        ColorOptionModel(color:.gray),
        ColorOptionModel(color:.orange),
        ColorOptionModel(color:.red,isOpacity: true),
        ColorOptionModel(color:.yellow,isOpacity: true),
        ColorOptionModel(color:.blue,isOpacity: true),
        ColorOptionModel(color:.green,isOpacity: true),
        ColorOptionModel(color:.pink,isOpacity: true),
        ColorOptionModel(color:.gray,isOpacity: true),
        ColorOptionModel(color:.orange,isOpacity: true)
    ]
    @Binding var currentColor: ColorOptionModel
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(colores, id: \.self) { color in
                    ColorItemView(
                        color: color,
                        isSelected: currentColor == color
                    )
                    .onTapGesture {
                        currentColor = color
                    }
                }.onAppear{
                    currentColor = colores[0]
                }
            }
        }
    }
}

struct ColorItemView: View {

    let color: ColorOptionModel
    let isSelected: Bool
    var body: some View {
        if isSelected {
            Image(systemName: "smallcircle.fill.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
                .foregroundColor(color.color)
        } else {
            Circle()
                .frame(width: 25)
                .foregroundColor(color.color)
                .opacity(color.isOpacity ? 0.5 : 1)
        }
    }
}

#Preview {
    @State var currentColor: ColorOptionModel = ColorOptionModel()
    PanelColoresView(currentColor: $currentColor)
}
