//
//  CardListaView.swift
//  ToDoList
//
//  Created by Desarrollo on 30/03/26.
//

import SwiftUI

struct CardListaView: View {
    @EnvironmentObject var router:Router
    @EnvironmentObject var todoVM:TodoHomeViewModel
    var lista:TodoListModel
    var body: some View {
        VStack(alignment: .leading,spacing: 4){
            Image(systemName: lista.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25,height: 25)
                .foregroundColor(.white)
            
            Text(lista.nombre.capitalized)
                .foregroundColor(.white)
                .font(.system(size: 15))
                .bold()
                .lineLimit(1)
            
            Text("* \(todoVM.getCountTaskCompleted(lista:lista)) Tareas")
                .font(.system(size: 10))
                .foregroundColor(.white)
            
            Image(systemName: "plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 13,height: 13)
                .foregroundColor(.white)
        }
        .padding(.horizontal)
        .frame(width: 110, height: 130)
        .background(lista.colorOption.color)
        .cornerRadius(20)
        .onTapGesture {
            todoVM.showCurrentList(currentList: lista)
        }
    }
}

#Preview {
    CardListaView(lista:TodoListModel(nombre: "Tareas De Casa", image: "house", colorOption: ColorOptionModel(color: .blue,isOpacity: false)))
}
