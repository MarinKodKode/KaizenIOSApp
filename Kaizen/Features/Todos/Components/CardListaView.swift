//
//  CardListaView.swift
//  ToDoList
//
//  Created by Desarrollo on 30/03/26.
//

import SwiftUI

struct CardListaView: View {
    @EnvironmentObject var router:Router
    @ObservedObject var todoVM:TodoHomeViewModel
    var lista:ListEntity
    
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
        .background(Color(hex: lista.color))
        .cornerRadius(20)
        .shadow(color: Color(hex: lista.color).opacity(1),radius: 4, y: 2)
        .onTapGesture {
            todoVM.showCurrentList(currentList: lista)
        }
    }
}

#Preview {
    @StateObject var todoVM:TodoHomeViewModel = TodoHomeViewModel()
    @StateObject var router:Router = Router()
    CardListaView(todoVM:todoVM,lista:ListEntity(nombre: "Pendientes de hoy", image: "house", color: "ddhsf2"))
        .environmentObject(router)
}
