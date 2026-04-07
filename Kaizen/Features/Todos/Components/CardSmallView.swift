//
//  CardSmallView.swift
//  ToDoList
//
//  Created by Desarrollo on 27/03/26.
//

import SwiftUI

struct CardSmallView:View {
    @ObservedObject var todoVM:TodoHomeViewModel
    var todo:TodoEntity
    @State var colorBell:Color = .gray
    var body: some View {
        VStack(alignment:.leading,spacing: 10){
            HStack(){
                Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(todo.completed ? .green : .gray)
                    .onTapGesture {
                        todoVM.taskCompleted(currentTask: todo)
                    }
                Text(todo.todoName)
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .strikethrough(todo.completed)
                Spacer()
                Image(systemName: todo.favorites ? "star.fill" : "star")
                    .foregroundColor(colorBell)
                    .onTapGesture {
//                        todo.favorites.toggle()
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
