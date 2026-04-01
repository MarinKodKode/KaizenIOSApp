import SwiftUI

struct PanelColoresView: View {
    @State var colores: [Color] = [
        .red,
        .blue,
        .yellow,
        .green,
        .orange,
    ]
    @Binding var currentColor: Color
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
                }.onAppear {
                    currentColor = colores[0]
                }
            }
        }
    }
}

struct ColorItemView: View {
    let color: Color
    let isSelected: Bool
    var body: some View {
        if isSelected {
            Image(systemName: "smallcircle.fill.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
                .foregroundColor(color)
        } else {
            Circle()
                .frame(width: 25)
                .foregroundColor(color)
        }
    }
}

#Preview {
    @State var currentColor: Color = .blue
    PanelColoresView(currentColor: $currentColor)
}
