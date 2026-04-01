import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var router: Router
    @StateObject var todoVM:TodoHomeViewModel = TodoHomeViewModel()
    
    var body: some View {
        ZStack {
            NavigationStack(path: $router.pathArray) {
                TodoHomeView(todoVM:todoVM)
                    .navigationDestination(for: Routes.self) { destination in
                        switch destination {
                        case .home:
                            TodoHomeView(todoVM:todoVM)
                        case .createAndModifyToDo:
                            CreateTodoListView(todoVM: todoVM)
                                .navigationBarBackButtonHidden(true)
                        default:
                            EmptyView()
                        }
                    }
            }
            .task {
                todoVM.configure(context: context)
            }
        }
    }
}

//#Preview {
//    @StateObject var router = Router()
//    @StateObject var todoVm = TodoHomeViewModel()
//    ContentView()
//        .environmentObject(router)
//}
