//
//  CreateTodoListView.swift
//  ToDoList
//
//  Created by Desarrollo on 31/03/26.
//

import SwiftUI

enum Filter: String, CaseIterable {
    case all = "Todo"
    case open = "Abierto"
    case closed = "Cerrado"
}

struct CreateTodoListView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var todoVM: TodoHomeViewModel
    @State var selectedFilter: Filter = .all

    var body: some View {

        GeometryReader { geo in

            let totalW = geo.size.height
            let totalH = geo.size.height
            let blackWidth = totalW * 0.75
            let blackheight = totalH * 0.25

            ZStack(alignment: .top) {
                todoVM.currentColor
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    HStack(spacing: 20) {
                        Button(
                            action: { todoVM.defaultView() },
                            label: {
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .overlay(
                                        Circle().stroke(
                                            Color.gray.opacity(0.5),
                                            lineWidth: 1
                                        )
                                    )
                            }
                        )
                        Spacer()
                        Button(
                            action: {},
                            label: {
                                Image(systemName: "calendar")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .overlay(
                                        Circle().stroke(
                                            Color.gray.opacity(0.5),
                                            lineWidth: 1
                                        )
                                    )
                            }
                        )

                        Button(
                            action: {},
                            label: {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .overlay(
                                        Circle().stroke(
                                            Color.gray.opacity(0.5),
                                            lineWidth: 1
                                        )
                                    )
                            }
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Text(todoVM.currentList?.nombre ?? "Pendientes")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: blackheight)
                .padding(.horizontal)

                VStack {
                    Spacer()
                    VStack(spacing: 30) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Tareas")
                                    .font(.title2)
                                    .bold()
                                Text("Lunes, 13 Abril")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }

                            Spacer()

                            Button(
                                action: { todoVM.crearTodo = true },
                                label: {
                                    Text("+ Nueva Tarea")
                                        .font(.system(size: 14))
                                        .bold()
                                }
                            )
                            .padding(.vertical, 10)
                            .padding(.horizontal, 14)
                            .background(.blue.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .padding(.top)

                        HStack(alignment: .center, spacing: 30) {
                            ForEach(Filter.allCases, id: \.self) { item in
                                FilterTask(
                                    todoVM: todoVM,
                                    selectedFilter: $selectedFilter,
                                    item: item
                                )
                            }
                        }

                        ScrollView {
                            VStack {
                                LazyVStack {
                                    ForEach(
                                        todoVM.filteredTask(
                                            for: selectedFilter
                                        ),
                                        id: \.self
                                    ) { item in
                                        CardTask(todoVM: todoVM, todo: item)
                                    }
                                }
                            }.padding()
                        }

                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: blackWidth)
                    .padding(.horizontal)
                    .background(
                        Color.white
                    )
                }
                .ignoresSafeArea()
            }
        }
        .sheet(isPresented: $todoVM.crearList) {
            AgregarListaView(todoVM: todoVM)
                .interactiveDismissDisabled(true)
                .presentationDetents([.fraction(0.25)])
        }
        .sheet(isPresented: $todoVM.crearTodo) {
            AgregarTareaView(todoVM: todoVM)
                .presentationDetents([.fraction(0.15)])
        }
        .onAppear {
            todoVM.crearList = todoVM.isModify ? false : true
        }
    }
}

struct FilterTask: View {
    @ObservedObject var todoVM: TodoHomeViewModel
    @Binding var selectedFilter: Filter
    var item: Filter
    var body: some View {
        HStack {

            Text(item.rawValue)
                .foregroundColor(selectedFilter == item ? .blue : .gray)
                .font(.system(size: 14))
                .bold()

            Text("\(todoVM.counts[item] ?? 0)")
                .font(.system(size: 12))
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(selectedFilter == item ? .blue : .gray)
                .clipShape(Capsule())
        }
        .onTapGesture {
            selectedFilter = item
        }
    }
}

struct CardTask: View {
    @ObservedObject var todoVM: TodoHomeViewModel
    var todo: TodoEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Nombre de la tarea")
                        .bold()
                        .strikethrough(todo.completed)
                    Spacer()
                    Button(
                        action: { todoVM.taskCompleted(currentTask: todo) },
                        label: {
                            Image(
                                systemName: todo.completed
                                    ? "checkmark.circle.fill"
                                    : "circle"
                            )
                            .font(.system(size: 25))
                            .foregroundColor(
                                todo.completed ? .blue : .gray
                            )
                        }
                    )
                }

                Text(todo.todoName)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Divider()
            Text("Today 10:00PM")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 2)
    }
}

#Preview {
    @StateObject var router = Router.shared
    @StateObject var todo = TodoHomeViewModel()

    CreateTodoListView(todoVM: todo)
        .environmentObject(router)
}
