//
//  Database.swift
//  MyTodoApp
//
//  Created by Noor Walid on 25/04/2021.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataDatabase {
    //Applying All CRUD operations for all databases using this protocol
    
    func create()
    func getData()
    func update()
    func delete()
}

struct CoreData: CoreDataDatabase {
    let context = (UIApplication.shared.delegate as! AppDelegate).CoreDataDatabase.viewContext
    
    func create() {
        
    }
    
    func getData() {
        do {
            
        }
        catch {
            print("There was an error fetching request of Categories class. \(error.localizedDescription)")
        }
    }
    
    func update() {
        
    }
    
    func delete() {
        
    }
    
}
