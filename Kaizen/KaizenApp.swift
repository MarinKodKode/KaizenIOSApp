import SwiftUI
import SwiftData

@main
struct KaizenApp: App {
    
    @StateObject var router = Router.shared
    @StateObject var todo = TodoViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
                .environmentObject(todo)
        }.modelContainer(PersistenceController.shared.container)
    }
}
