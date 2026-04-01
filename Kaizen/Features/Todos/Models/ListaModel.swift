import Foundation
import SwiftUI

struct TodoListModel: Identifiable,Hashable{
    let id:String = UUID().uuidString
    var nombre:String
    var image:String
    var colorOption:ColorOptionModel
    var todos:[TodoModel] = []
}

struct TodoModel:Identifiable,Hashable{
    let id:String = UUID().uuidString
    var todoName:String = ""
    var completed:Bool = false
    var favorites:Bool = false
    var date:Date = Date()
}
