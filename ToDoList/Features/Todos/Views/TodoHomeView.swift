//
//  TodoHomeView.swift
//  ToDoList
//
//  Created by Desarrollo on 27/03/26.
//

import SwiftUI

struct TodoHomeView: View {
    @State var crearTodo = false
    @State var title = ""
    @State var descripcion = ""
    let gridItems = [GridItem(.flexible())]
    var todos = [
        TodoModel(
            title: "Tarea 1",
            description: "esta es una descripcion de la tarea 1"
        ),
        TodoModel(
            title: "Tarea 1",
            description: "esta es una descripcion de la tarea 1"
        ),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        //                 TodoModel(title: "Tarea 1",description: "esta es una descripcion de la tarea 1"),
        TodoModel(
            title: "Tarea 1",
            description: "esta es una descripcion de la tarea 1"
        ),
    ]
    
    var body: some View{
        ZStack{
            Text("Hoy: 30 Marzo")
                .font(.title)
        }
    }
    
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Lista de tareas")
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .font(.title)
//                    .bold()
//                Spacer()
//                Image(systemName: "plus")
//                    .onTapGesture {
//                        crearTodo = true
//                    }
//            }
//            .padding(.horizontal)
//            Divider()
//            ScrollView {
//                LazyVGrid(columns: gridItems) {
//                    ForEach(todos, id: \.self) { todo in
//                        CardSmallView(todo: todo)
//                    }
//                }.padding(.horizontal)
//            }
//            Spacer()
//        }
//            .sheet(isPresented: $crearTodo) {
//                CrearTodoView(
//                    title: $title,
//                    descripcion: $descripcion,
//                    crearTodo: $crearTodo
//                )
//            }
//    }
}

struct CrearTodoView: View {
    @Binding var title: String
    @Binding var descripcion: String
    @Binding var crearTodo: Bool
    var body: some View {
        ZStack(alignment: .bottom){
            VStack {
                TextField("Titulo", text: $title)
                    .font(.title)
                    .bold()
                    .padding(.top, 10)
                    .padding(.vertical, 5)
                Divider()
                TextEditor(text: $descripcion)
                Spacer()
            }.padding(.horizontal)
            
            Button("Crear",action:{})
        }
    }
}

struct TodoModel: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String = ""
    var description: String = ""
}

#Preview {
    TodoHomeView()
}
