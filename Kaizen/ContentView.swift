import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var router: Router
    @EnvironmentObject var todoVm: TodoViewModel
    var body: some View {
        ZStack {
            NavigationStack(path: $router.pathArray) {
                TodoHomeView()
//                    .task {
//                        todoVm.setContext(context)
//                    }
                    .navigationDestination(for: Routes.self) { destination in
                        switch destination {
                        case .home:
                            TodoHomeView()
                        case .createAndModifyToDo:
                            CreateTodoListView()
                                .navigationBarBackButtonHidden(true)
                        default:
                            Text("Sin definir destino")
                        }
                    }
            }
        }
    }
}

//#Preview {
//    @StateObject var router = Router()
//    @StateObject var todoVm = TodoViewModel()
//    ContentView()
//        .environmentObject(router)
//        .environmentObject(todoVm)
//}
