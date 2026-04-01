//
//  Kaizen.swift
//  Kaizen
//
//  Created by Lettuce, Gaona & KodKode on 30/03/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    @EnvironmentObject var router : Router
    
    @ObservedObject private  var todoVm : TodoViewModel = TodoViewModel()
    
    var body: some View {
        
        NavigationStack(path: $router.pathArray) {
            Group {
                MainTabView()
            }
            .navigationDestination(for: Routes.self) { route in
                switch route {
                case .home:
                    TodoHomeView()
                case .createAndModifyToDo:
                    CreateTodoListView()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
