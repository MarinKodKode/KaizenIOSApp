import Foundation
import Combine
import SwiftUI

class TodoHomeViewModel:ObservableObject{
    @Published var listas:[TodoListModel] = [
//        TodoListModel(nombre: "Desing", image: "paintbrush.pointed.fill",colorOption: ColorOptionModel(color: .red,isOpacity: false)),
//        TodoListModel(nombre: "Meeting", image: "person.3.fill",colorOption: ColorOptionModel(color: .orange,isOpacity: false)),
//        TodoListModel(nombre: "Learning", image: "brain",colorOption: ColorOptionModel(color: .green,isOpacity: false)),
    ]
    @Published var title = "Lista sin titulo"
    @Published var categoria = ""
//    @Published var crearTodo:Bool = true
    @Published var currentColor: ColorOptionModel = ColorOptionModel()
    @Published var currentList:TodoListModel?
    @Published var isModify:Bool = false
    
    func defaultView(){
        Router.shared.popToRoot()
        title = "Lista sin titulo"
        currentList = nil
        isModify = false
    }
    
    func createNewList(title:String,color:ColorOptionModel){
        let titleF = title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Pendientes" : title.trimmingCharacters(in: .whitespacesAndNewlines)
        let newList = TodoListModel(nombre: titleF, image: "house", colorOption: color)
        listas.append(newList)
        currentList = newList
        self.title = title
    }
    
    func createNewTodo(name:String){
        let newTodo = TodoModel(todoName: name, date: Date())
        guard let current = currentList else{
            return
        }
        if let index = listas.lastIndex(of: current) {
            currentList?.todos.append(newTodo)
            listas[index].todos.append(newTodo)
        }
    }
    
    func showCurrentList(currentList:TodoListModel){
        isModify = true
        self.currentList = currentList
        Router.shared.navigate(to: .createAndModifyToDo)
    }
}
