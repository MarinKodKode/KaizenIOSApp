import Foundation
import Combine
import SwiftUI
import SwiftData

class TodoHomeViewModel:ObservableObject{
    //Lista
    @Published var listas:[ListEntity] = []
    @Published var title = ""
    @Published var currentColor: Color = .red
    @Published var currentList:ListEntity?
    @Published var isModify:Bool = false
    @Published var isModifyList:Bool = false
    @Published var crearList = true
    
    //Todo
    @Published var crearTodo = false
    
    //Sheets Mejora
    @Published var mejoras:[MejoraModel] = []
    @Published var mejoraActual:MejoraModel?
    @Published var descripcion:String = ""
    @Published var seleccionado:Nivel = .bajo
    @Published var openMejora:Bool = false
    
    private var repository:ListRepository?
    
    init(){
        
    }
    
    func configure(context: ModelContext){
        self.repository = ListRepository(context: context)
    }
    
    func defaultView(){
        Router.shared.popToRoot()
        title = ""
        currentList = nil
        isModify = false
        mejoraActual = nil
    }
    
    func loadLists(){
        guard let repo = repository else {
            return
        }
        
        listas = repo.getLists()
    }
    
    func createNewList(){
        guard let repo = repository else {
            return
        }
        let newList = ListEntity(nombre: title, image: "house", color: currentColor.toHex() ?? "")
        repo.addList(list: newList)
        currentList = newList
        crearList = false
        loadLists()
    }
    
    func createNewTodo(name:String){
        
        guard let repo = repository, let current = currentList else{
            return
        }
        let todo = TodoEntity(todoName: name, completed: false, favorites: false, date: Date(),list:currentList)
        repo.addTodo(todo: todo, currentList: current)
    }
    
    func preModiciarLista(){
        if let current = currentList {
            title = current.nombre
            currentColor = Color(hex: current.color)
            isModifyList = true
            crearList = true
        }
    }
    
    func modificarLista(){
        if let current = currentList,let index = listas.lastIndex(of: current) {
            var tempList = listas[index]
            tempList.nombre = title
            tempList.color = currentColor.toHex() ?? ""
            
            guard let repo = repository, let current = currentList else{
                return
            }
            repo.modifyList(list: tempList, title: title, color: current.color)
            
            crearList = false
            listas[index] = tempList
            isModifyList = false
        }
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
    
    ///////////
    ///////////
    ///////////
    ///////////
    
    func defaultSheetAgregarMejora(){
        descripcion = ""
        seleccionado = .bajo
        mejoraActual = nil
        openMejora = false
    }
    
    func agregarMejora(){
        let newMejora = MejoraModel(descripcion: descripcion,nivel: seleccionado.rawValue,color: seleccionado.color)
        mejoras.append(newMejora)
        defaultSheetAgregarMejora()
    }
    
    func modificatMejoraDatos(mejora:MejoraModel){
        mejoraActual = mejora
        descripcion = mejora.descripcion
        seleccionado = Nivel(rawValue: mejora.nivel) ?? .bajo
        openMejora = true
    }
    
    func modificarMejora(mejora:MejoraModel){
        if let index = mejoras.lastIndex(of: mejora) {
            let newMejora = MejoraModel(descripcion: descripcion, nivel: seleccionado.rawValue, color: seleccionado.color)
            mejoras[index] = newMejora
            defaultSheetAgregarMejora()
        }
    }
}
