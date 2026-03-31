import SwiftData
import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            NoteHomeView()
                .tabItem {
                    Label("Notes", systemImage: "note")
                }
            TodoHomeView()
                .tabItem {
                    Label("Todos", systemImage: "list.clipboard")
                }
        }
    }
}

struct NoteHomeView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var todoVm: TodoViewModel
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Text("Todas las notas")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                    .bold()
                Divider()
                ScrollView {
                    LazyVGrid(
                        columns: gridItems,
                        spacing: 30,
                        content: {
                            ForEach(todoVm.todos, id: \.self) { todo in
                                CardView(
                                    todo: todo,
                                    action: {
                                        todoVm.modificarNota(todo: todo)
                                    }
                                )
                            }
                        }
                    )
                }
                Spacer()
            }.padding(.horizontal)

            Button {
                router.navigate(to: .createAndModifyToDo)
            } label: {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.red)
                    .padding()
            }
            .background(.white)
            .clipShape(Circle())
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
            .padding()
        }.onAppear {
            todoVm.loadTodos()
        }
    }
}

//#Preview {
//    HomeView()
//}
