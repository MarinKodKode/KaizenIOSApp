//
//  Modifiers.swift
//  Kaizen
//
//  Created by Desarrollo on 06/04/26.
//

import Foundation
import SwiftUI

//struct ExampleStyle:ViewModifier{
//    func body(content: Content) -> some View{
//        //Agregar estilos al conte content
//        content
//    }
//}

struct CardDashStyle:ViewModifier{
    var dashColor:Color
    var cornerRadius:CGFloat
    var dashLineWidth: CGFloat
    var segmentDash: CGFloat
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: dashLineWidth,
                            dash: [segmentDash]
                        )
                    )
                    .foregroundColor(dashColor)
            )
    }
}

struct CardRoundedRectangleStyle:ViewModifier{
    var bgColor:Color
    var cornerRadius:CGFloat
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(bgColor)
            )
    }
}

    
