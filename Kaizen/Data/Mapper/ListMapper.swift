//
//  ListMapper.swift
//  Kaizen
//
//  Created by Desarrollo on 01/04/26.
//

import Foundation

extension ListEntity {
    func toDomain() -> TodoListModel{
        TodoListModel(id:id,nombre: nombre, image: image, color: color,todos: todos.map{ $0.toDomain()})
    }
}

extension TodoEntity {
    func toDomain() -> TodoModel {
        TodoModel(todoName: todoName, completed: completed, favorites: favorites, date: date)
    }
}

extension TodoListModel{
    func toEntity() -> ListEntity {
        let entity = ListEntity(id: id, nombre: nombre, image: image, color: color)
            entity.todos = todos.map{ $0.toEntity(parent: entity) }
            return entity
    }
}

extension TodoModel {
    func toEntity(parent: ListEntity) -> TodoEntity{
        let entity = TodoEntity(id: id, todoName: todoName, completed: completed, favorites: favorites, date: date)
        entity.list = parent
        return entity
    }
}
