import Foundation
import SwiftData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(
                for: Todo.self
            )
        } catch {
            fatalError("Error: \(error)")
        }
    }
}
