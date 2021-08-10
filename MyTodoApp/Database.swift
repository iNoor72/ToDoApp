//
//  Database.swift
//  MyTodoApp
//
//  Created by Noor Walid on 25/04/2021.
//

import Foundation
import UIKit
import CoreData

protocol Database {
    //Applying All CRUD operations for all databases using this protocol
    func create()
    func getData()
    func update()
    func deleteCategory(category: Categories)
    func deleteItem(item: Item)
    func save()
}
