//
//  CardSmallView.swift
//  ToDoList
//
//  Created by Desarrollo on 27/03/26.
//

import SwiftUI

struct CardSmallView:View {
    var todo:TodoModel
    @State var colorBell:Color = .gray
    @State var completed = false
    @State var favorite = false
    var body: some View {
        VStack(alignment:.leading,spacing: 10){
            HStack(){
                Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(completed ? .green : .gray)
                    .onTapGesture {
                        completed.toggle()
                    }
                Text(todo.description)
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .strikethrough(completed)
                Spacer()
                Image(systemName: favorite ? "star.fill" : "star")
                    .foregroundColor(colorBell)
                    .onTapGesture {
                        favorite.toggle()
                        if colorBell == .gray{
                            colorBell = .yellow
                        }else{
                            colorBell = .gray
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 35)
        .padding(10)
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 2)
    }
}

//#Preview {
//    CardSmallView()
//}
