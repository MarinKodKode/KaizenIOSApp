import Foundation
import SwiftData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(
                for: ListEntity.self,
                TodoEntity.self
            )
        } catch {
            fatalError("Error: \(error)")
        }
    }
}
