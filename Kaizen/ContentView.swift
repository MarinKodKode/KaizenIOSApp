import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var router: Router
    @EnvironmentObject var todoVm: TodoViewModel
    var body: some View {
        ZStack {
            NavigationStack(path: $router.pathArray) {
                HomeView()
                    .task {
                        todoVm.setContext(context)
                    }
                    .navigationDestination(for: Routes.self) { destination in
                        switch destination {
                        case .home:
                            HomeView()
                        case .createAndModifyToDo:
                            CreateToDoView()
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
