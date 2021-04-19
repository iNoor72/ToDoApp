//
//  TodoCell.swift
//  MyTodoApp
//
//  Created by Noor Walid on 11/16/20.
//

import UIKit

struct ToDoItem {
    var name: String
    var isDone = false
    
    mutating func markItemAsDone() {
        self.isDone = false
    }
}
