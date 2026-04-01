//
//  ListRepository.swift
//  Kaizen
//
//  Created by Desarrollo on 01/04/26.
//

import Foundation
import SwiftData

class ListRepository{
    private let context:ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func getLists() -> [ListEntity]{
        let descriptor = FetchDescriptor<ListEntity>()
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func addList(list:ListEntity){
        context.insert(list)
        do{
            try? context.save()
        }catch(let e){
            print("Error addList: \(e.localizedDescription)")
        }
    }
    
    func addTodo(todo:TodoEntity,currentList:ListEntity){
        var modList = currentList
        modList.todos.append(todo)
        
        do{
            try? context.save()
        }
    }
}
