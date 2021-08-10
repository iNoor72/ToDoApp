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
    var categories: [Categories]?
    var items = [Any]()
    deinit{
        print("deinit called from items")
    }
    
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
            let index = categories?.firstIndex(of: category ?? Categories())
            categories?[index ?? 0].items?.append(newItem)
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
            //This line crashes because the fetching is incorrect with the predicate, but it's the correct way to
            //fetch the items for the passed category.
            
            //items in categoryID
//            if let filter = category?.name {
//                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
//                request.predicate = NSPredicate(format: "items IN %@", filter)
//                items = try context.fetch(request)
//            }
            
//            categories = try context.fetch(Categories.fetchRequest())
//            if let safeCategories = categories {
//                for category in safeCategories {
//                    category.items = try context.fetch(Item.fetchRequest())
//                }
//            }
            
//            let request = NSFetchRequest<Item>(entityName: "Item")
//            //category?.items = try context.execute(request) as? [Item]
//            var result = try context.fetch(request) as? [Item]
//            print(result)
//            if let items = category?.items{
//                for item in items {
//                    print(items.first)
//                }
//            }

            
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
        return  category?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! ToDoItemCell
//        cell.nameLabel.text = categories?[indexPath.row ?? 0].items?[indexPath.row].name
//        cell.dateLabel.text = "\(categories?[indexPath.row ?? 0].items?[indexPath.row].createdAt)"
        
        cell.nameLabel.text = category?.items?[indexPath.row].name
        cell.dateLabel.text = "\(category?.items?[indexPath.row].createdAt)"

        
        return cell
    }
}
