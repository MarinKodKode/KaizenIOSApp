import Foundation

struct TodoModel:Identifiable,Hashable{
    let id = UUID()
    var todoName:String
    var completed:Bool
    var favorites:Bool
    var date:Date
}
