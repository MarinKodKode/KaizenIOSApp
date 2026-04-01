import SwiftUI
import SwiftData

@main
struct KaizenApp: App {
    
    @StateObject var router = Router.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
        }.modelContainer(PersistenceController.shared.container)
    }
}
