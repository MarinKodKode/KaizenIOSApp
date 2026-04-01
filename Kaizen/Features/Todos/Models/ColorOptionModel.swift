import Foundation
import SwiftUI

struct ColorOptionModel:Identifiable,Equatable,Hashable{
    let id = UUID()
    var color:Color = .red
    var isOpacity:Bool = false
}
