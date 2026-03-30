import Combine
import Foundation

class Router: ObservableObject {
    static let shared = Router()
    @Published var pathArray: [Routes] = []

    func navigate(to route: Routes) {
        if let lastRoute = pathArray.last, lastRoute == route {
            return
        } else {
            pathArray.append(route)
        }
    }

    func goBack(to route: Routes) {
        if let index = pathArray.lastIndex(of: route) {
            let pos = pathArray.count - 1 - index
            pathArray.removeLast(pos)
        }
    }

    func popToRoot() {
        pathArray = []
    }
}
