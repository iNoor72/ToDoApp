//
//  ItemViewController.swift
//  MyTodoApp
//
//  Created by Noor Walid on 21/04/2021.
//

import UIKit
import CoreData

class ItemViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).CoreDataDatabase.viewContext
    
    var category: Categories?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        itemTextField.delegate = self
        tableView.register(UINib(nibName: "ToDoItemCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        title = "\(category?.name ?? "No category passed here")"
        getItems()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if let itemName = itemTextField.text {
            //db.create(newcat)
            let newItem = Item(context: context)
            newItem.name = itemName
            newItem.createdAt = Date()
            category?.items?.append(newItem)
            //db.save()
            savingContext()
            //db.getdata(type)
            getItems()
            itemTextField.text = ""
        }
    }
    
    //MARK:- Core Data Functions
    func getItems() {
        do {
            //We need to change this line because it's not working to fetch the Items from the given Category, the whole problems is here 100%
//            category = try context.fetch(Categories.fetchRequest())
            //It crashes the fetching of categories
//            category?.items = try context.fetch(Item.fetchRequest())
            
        } catch {
            print("There was an error fetching request of Item class. \(error.localizedDescription)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func deleteItem(named item: Item){
        context.delete(item)
        savingContext()
        getItems()
    }
    
    func savingContext() {
        do {
            try context.save()
        } catch {
            print("There was a problem while saving new context. \(error.localizedDescription)")
        }
    }
    
    func updateItem(named item: Item){
        do {
            try context.setValue("", forKey: "Item")
        } catch {
            print("There was a problem while updating the Item. \(error.localizedDescription)")
        }
    }
}

//MARK:- TableView Delegate & DataSource Methods
extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! ToDoItemCell
        cell.nameLabel.text = category?.items?[indexPath.row].name
        cell.dateLabel.text = "\(category?.items?[indexPath.row].createdAt)"
        
        return cell
    }
}
