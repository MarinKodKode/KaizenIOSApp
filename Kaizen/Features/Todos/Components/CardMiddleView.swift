//
//  CardMiddleView.swift
//  ToDoList
//
//  Created by Desarrollo on 27/03/26.
//

import SwiftUI

struct CardMiddleView:View {
    @State var title:String = "Component Card"
    @State var description:String = "This is a description for the IOS Card we´re building"
    @State var colorBell:Color = .gray
    var body: some View {
        VStack(alignment:.leading,spacing: 10){
            HStack{
                Text(title)
                    .bold()
                Spacer()
                Image(systemName: "bell.circle")
                    .foregroundColor(colorBell)
                    .onTapGesture {
                        if colorBell == .gray{
                            colorBell = .yellow
                        }else{
                            colorBell = .gray
                        }
                    }
            }
            Text(description)
                .foregroundColor(.gray)
                .font(.footnote)
        }
        .frame(maxWidth: 240, maxHeight: 100)
        .padding(10)
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 2)
    }
}

#Preview {
    CardMiddleView()
}
