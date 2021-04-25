//
//  ItemViewController.swift
//  MyTodoApp
//
//  Created by Noor Walid on 21/04/2021.
//

import UIKit
import CoreData

class ItemViewController: UIViewController {
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).CoreDataDatabase.viewContext
    
    var category: Categories?
    var categoryItems = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ToDoItemCell", bundle: nil), forCellReuseIdentifier: "ToDoItemCell")
        title = "\(category?.name ?? "No category passed here")"
    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        if let itemName = itemTextField.text {
            //db.create(newcat)
            let newItem = Item(context: context)
            newItem.name = itemName
            newItem.createdAt = Date()
            categoryItems.append(newItem)
            category?.items?.append(newItem)
            //db.save()
            savingContext()
            //db.getdata(type)
            getItems()
        }
    }
    
    //MARK:- Core Data Functions
    func getItems() {
        do {
            //We need to change this line
            categoryItems = try context.fetch(Item.fetchRequest())
        }catch {
            print("There was an error fetching request of Item class. \(error.localizedDescription)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func deleteCategory(named category: Categories){
        context.delete(category)
        savingContext()
        getItems()
    }
    
    func savingContext() {
        do {
            try context.save()
        }catch {
            print("There was a problem while saving new context. \(error.localizedDescription)")
        }
    }
}

//MARK:- TableView Delegate & DataSource Methods
extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ToDoItemCell
        cell.nameLabel.text = category?.items?[indexPath.row].name
        cell.dateLabel.text = "\(category?.items?[indexPath.row].createdAt ?? Date())"
        
        return UITableViewCell()
    }
    
    
    
}
