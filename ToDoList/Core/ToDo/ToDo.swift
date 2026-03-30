import Foundation
import SwiftData

@Model
class Todo{
    var id = UUID().uuidString
    var title:String = ""
    var note:String = ""
    var date:Date = Date()
    
    init(title: String, note: String, date: Date) {
        self.title = title
        self.note = note
        self.date = date
    }
}
