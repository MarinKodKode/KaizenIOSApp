//
//  CardBigView.swift
//  ToDoList
//
//  Created by Desarrollo on 27/03/26.
//

import SwiftUI

struct CardBigView:View {
    @State var title:String = "Component Card"
    @State var description:String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    var body: some View {
        VStack(alignment:.leading,spacing: 10){
            HStack{
                Text(title)
                    .bold()
                Spacer()
                Image(systemName: "minus")
                    .foregroundColor(.black)
            }
            
            Text(description)
                .foregroundColor(.gray)
                .font(.footnote)
            Spacer()
            
            Button(action: {}, label: {
                HStack(spacing: 5){
                    Text("Listen Now")
                        .foregroundColor(.white)
                        .font(.system(size: 10))
                        .bold()
                        
                    
                    Image(systemName: "arrow.forward")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 9,height: 9)
                        .foregroundColor(.white)
                }.padding(8)
            })
            .background(.black)
            .cornerRadius(15)
        }
        .frame(maxWidth: 240, maxHeight: 200)
        .padding(10)
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 2)
    }
}

#Preview {
    CardBigView()
}
