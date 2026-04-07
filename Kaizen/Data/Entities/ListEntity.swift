import Foundation
import SwiftData
import SwiftUI

@Model
class ListEntity {
    var id:UUID
    var nombre:String
    var image:String
    var color:String
    
    @Relationship(deleteRule: .cascade)
    var todos:[TodoEntity] = []
    
    init(id: UUID = UUID(), nombre: String, image: String,color:String) {
        self.id = id
        self.nombre = nombre
        self.image = image
        self.color = color
    }
}
