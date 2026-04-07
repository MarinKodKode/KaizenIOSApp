import Foundation
import SwiftData

@Model
class TodoEntity{
    let id:UUID
    var todoName:String
    var completed:Bool
    var favorites:Bool
    var date:Date
    var list:ListEntity?
    
    init(id: UUID = UUID(), todoName: String, completed: Bool, favorites: Bool, date: Date, list: ListEntity? = nil) {
        self.id = id
        self.todoName = todoName
        self.completed = completed
        self.favorites = favorites
        self.date = date
        self.list = list
    }
}
