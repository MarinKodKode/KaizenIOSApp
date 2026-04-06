import Foundation
import SwiftUI

//Ejemplo de como llamar el estilo del view viewModifier
//extension View{
//    func exampleStyle() -> some View{
//        self.modifier(ExampleStyle())
//    }
//}

extension View {
    func cardDashStyle(
        dashColor: Color,
        cornerRadius: CGFloat,
        dashLineWidth: CGFloat,
        segmentDash: CGFloat
    ) -> some View {
        self.modifier(
            CardDashStyle(
                dashColor: dashColor,
                cornerRadius: cornerRadius,
                dashLineWidth: dashLineWidth,
                segmentDash: segmentDash
            )
        )
    }
}

extension View {
    func cardRoundedRectangleStyle(
        bgColor:Color,
        cornerRadius:CGFloat
    ) -> some View {
        self.modifier(CardRoundedRectangleStyle(bgColor: bgColor, cornerRadius: cornerRadius))
    }
}
