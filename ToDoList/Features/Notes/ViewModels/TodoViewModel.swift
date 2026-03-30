import SwiftUI
import SwiftData
import Foundation
import Combine
//import Combine

class TodoViewModel: ObservableObject {

    var isNoteModify: Bool = false
    private var repository: TodoRepository?

    @Published var title: String = ""
    @Published var note: String = ""
    @Published var todos: [Todo] = []
    @Published var timer: Timer?
    @Published var progress: CGFloat = 0
    var currentNote: Todo = Todo(title: "", note: "", date: Date())

    func setContext(_ context: ModelContext) {
        guard repository == nil else { return }
        self.repository = TodoRepository(context: context)
        loadTodos()
    }

    func defaultView() {
        isNoteModify = false
        title = ""
        note = ""
    }

    func modificarNota(todo: Todo) {
        isNoteModify = true
        title = todo.title
        note = todo.note
        currentNote = todo
        Router.shared.navigate(to: .createAndModifyToDo)
    }

    func createNote() {
        if !isNoteModify {
            if !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                || !note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            {
                let newTodo = Todo(title: title, note: note, date: Date())
                repository?.addTodo(todo: newTodo)
            }
        } else {
            repository?.update(todo: currentNote, title: title, note: note)
        }

        defaultView()
    }

    func loadTodos() {
        todos = repository?.fetchTodos() ?? []
    }
    
    func borrarTarea(){
        repository?.deleteTodo(todo: currentNote)
        isNoteModify = false
        defaultView()
        loadTodos()
        Router.shared.popToRoot()
    }
}
