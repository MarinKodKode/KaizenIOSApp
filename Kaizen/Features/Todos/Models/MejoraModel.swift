import Foundation

struct MejoraModel: Identifiable,Equatable{
    var id:UUID = UUID()
    var descripcion:String
    var nivel:String
    var color:String
}
