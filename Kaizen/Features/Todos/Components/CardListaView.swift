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
        VStack(alignment: .leading){
            
            HStack{
                Text(lista.nombre.capitalized)
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    .bold()
                    .lineLimit(2)
                Spacer()
                Image(systemName: "tray.circle.fill")
                    
                    .foregroundStyle(.white, .black.opacity(0.5))
                    .font(.system(size: 25))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            
            Spacer()
            
            HStack{
                Text( (lista.todos.isEmpty ? "Completar commit para manasd" : lista.todos.randomElement()?.todoName)! )
                    .font(.caption)
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(2)
                Spacer()
                Text("\(Int(todoVM.getProgressList(listaActual: lista) * 100))%")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            
            ProgressView(value: todoVM.getProgressList(listaActual: lista) )
                .tint(todoVM.getProgressList(listaActual: lista) >= 1.0 ? .gray : .white)
                .padding(.bottom)
        }
        .frame(width: 200, height: 140)
        .padding(.horizontal)
        .shadow(color: Color(hex: lista.color).opacity(1),radius: 4, y: 2)
        .cardRoundedRectangleStyle(bgColor: Color(hex: lista.color), cornerRadius: 20)
        .onTapGesture {
            todoVM.showCurrentList(currentList: lista)
        }
    }
}

#Preview {
    @StateObject var todoVM:TodoHomeViewModel = TodoHomeViewModel()
    @StateObject var router:Router = Router()
    CardListaView(todoVM:todoVM,lista:ListEntity(nombre: "Oficina Tareas para hoy", image: "house", color: Color(.red).toHex()!))
        .environmentObject(router)
}
