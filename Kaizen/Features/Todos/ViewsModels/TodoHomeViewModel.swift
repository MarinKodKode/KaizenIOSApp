import Foundation
import Combine
import SwiftUI
import SwiftData

class TodoHomeViewModel:ObservableObject{
    @Published var listas:[ListEntity] = []
    @Published var mejoras:[MejoraModel] = []
    @Published var title = "Lista sin titulo"
    @Published var categoria = ""
    @Published var currentColor: Color = .red
    @Published var currentList:ListEntity?
    @Published var isModify:Bool = false
    
    private var repository:ListRepository?
    
    init(){
        
    }
    
    func configure(context: ModelContext){
        self.repository = ListRepository(context: context)
    }
    
    func defaultView(){
        Router.shared.popToRoot()
        title = "Lista sin titulo"
        currentList = nil
        isModify = false
    }
    
    func loadLists(){
        guard let repo = repository else {
            return
        }
        
        listas = repo.getLists()
    }
    
    func createNewList(title:String,color:Color){
//        let titleF = title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Pendientes" : title.trimmingCharacters(in: .whitespacesAndNewlines)
//        let newList = TodoListModel(id:UUID(),nombre: titleF, image: "house", color: color.toHex() ?? "",todos: [])
//        listas.append(newList)
//        currentList = newList
//        self.title = title
        guard let repo = repository else {
            return
        }
        let newList = ListEntity(nombre: title, image: "house", color: color.toHex() ?? "")
        repo.addList(list: newList)
        self.title
        currentList = newList
        loadLists()
    }
    
    func createNewTodo(name:String){
//        let newTodo = TodoModel(todoName: name,completed: false,favorites: false,date: Date())
//        guard let current = currentList else{
//            return
//        }
//        if let index = listas.lastIndex(of: current) {
//            currentList?.todos.append(newTodo)
//            listas[index].todos.append(newTodo)
//        }
        
        guard let repo = repository, let current = currentList else{
            return
        }
        let todo = TodoEntity(todoName: name, completed: false, favorites: false, date: Date(),list:currentList)
        repo.addTodo(todo: todo, currentList: current)
    }
    
    func showCurrentList(currentList:ListEntity){
        isModify = true
        self.currentList = currentList
        self.currentColor = Color(hex: currentList.color)
        Router.shared.navigate(to: .createAndModifyToDo)
    }
    
    func taskCompleted(currentTask:TodoEntity){
        let value = !currentTask.completed
        guard let current = currentList else{
            return
        }
        if let index = listas.lastIndex(of: current), let indexTodos = current.todos.lastIndex(of: currentTask) {
            var todoTemp = current.todos[indexTodos]
            todoTemp.completed = value
            currentList?.todos[indexTodos] = todoTemp
            listas[index].todos[indexTodos] = todoTemp
        }
    }
    
    func getCountTaskCompleted(lista:ListEntity) -> Int {
        let count = lista.todos.filter { !$0.completed }.count
        return count
    }
    
    func agregarMejora(descripcion:String){
        let newMejora = MejoraModel(descripcion: descripcion)
        mejoras.append(newMejora)
    }
}
