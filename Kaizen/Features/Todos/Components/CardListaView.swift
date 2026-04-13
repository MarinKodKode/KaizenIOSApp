//
//  CardListaView.swift
//  ToDoList
//
//  Created by Desarrollo on 30/03/26.
//

import SwiftUI

struct CardListaView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var todoVM: TodoHomeViewModel
    var lista: ListEntity

    var body: some View {
        VStack(alignment: .leading) {

            HStack(alignment: .top) {
                Text(lista.nombre.capitalized)
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    .bold()
                Spacer()
                Image(systemName: "tray.circle.fill")
                    .foregroundStyle(.white, .black.opacity(0.5))
                    .font(.system(size: 25))
            }
            .frame(maxWidth: .infinity)
            .padding(.top)
            
            Spacer()

            VStack {
                HStack {
                    Text("Progreso")
                        .font(.caption)
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                    Text(
                        "\(Int(todoVM.getProgressList(listaActual: lista) * 100))%"
                    )
                    .font(.caption)
                    .foregroundColor(.white)
                }

                ProgressView(value: todoVM.getProgressList(listaActual: lista))
                    .tint(.white)
            }

            HStack {
                Image(systemName: "calendar")
                    .font(.footnote)
                    .foregroundColor(.white)

                Text("Abril 13")
                    .font(.footnote)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.vertical)
        }
        .frame(width: 200, height: 140)
        .padding(.horizontal)
        .shadow(color: Color(hex: lista.color).opacity(1), radius: 4, y: 2)
        .cardRoundedRectangleStyle(
            bgColor: Color(hex: lista.color),
            cornerRadius: 20
        )
        .onTapGesture {
            todoVM.showCurrentList(currentList: lista)
        }
    }
}

#Preview {
    @StateObject var todoVM: TodoHomeViewModel = TodoHomeViewModel()
    @StateObject var router: Router = Router()
    CardListaView(
        todoVM: todoVM,
        lista: ListEntity(
            nombre: "Oficina Tareas para hoy",
            image: "house",
            color: Color(.red).toHex()!
        )
    )
    .environmentObject(router)
}
