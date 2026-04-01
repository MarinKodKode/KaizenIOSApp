import Foundation
import SwiftUI

struct TodoListModel: Identifiable,Hashable{
    let id:UUID
    var nombre:String
    var image:String
    var color:String
    var todos:[TodoModel]
}


