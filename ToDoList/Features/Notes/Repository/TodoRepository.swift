import Foundation
import SwiftData

protocol TodoRepositoryProtocol{
    func fetchTodos() -> [Todo]
    func addTodo(todo:Todo)
//    func deleteTodo()
}

class TodoRepository:TodoRepositoryProtocol{
    private let context:ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchTodos() -> [Todo] {
        let descriptor = FetchDescriptor<Todo>(
            sortBy: [SortDescriptor(\.date,order: .reverse)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func addTodo(todo:Todo){
        context.insert(todo)
        
        do{
            try context.save()
        }catch{
            print("No se guardo")
        }
    }
    
    func update(todo:Todo,title:String = "", note:String=""){
        todo.title = title
        todo.note = note
        do{
            try context.save()
        }catch{
            
        }
    }
    
    func deleteTodo(todo:Todo){
        do{
            try context.delete(todo)
        }catch{
            
        }
    }
    
    
}
