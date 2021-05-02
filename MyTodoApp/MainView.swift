//
//  ViewController.swift
//  MyTodoApp
//
//  Created by Noor Walid on 11/16/20.
//

import UIKit
import CoreData

class MainView: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).CoreDataDatabase.viewContext
    
    var categoriesArray = [Categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories()
        tableView.delegate = self
        tableView.dataSource = self
        categoryTextField.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if let categoryName = categoryTextField.text {
            //db.create(newcat)
            let newCategory = Categories(context: context)
            newCategory.name = categoryName
            categoriesArray.append(newCategory)
            //db.save()
            savingContext()
            //db.getdata(type)
            getCategories()
            categoryTextField.text = ""
        }
    }
    
    
    
    //MARK:- Core Data Functions
    func getCategories() {
        do {
            categoriesArray = try context.fetch(Categories.fetchRequest())
        }catch {
            print("There was an error fetching request of Categories class. \(error.localizedDescription)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func deleteCategory(named category: Categories){
        context.delete(category)
        savingContext()
        getCategories()
    }
    
    func savingContext() {
        do {
            try context.save()
        }catch {
            print("There was a problem while saving new context. \(error.localizedDescription)")
        }
    }
    
    func updateCategory(named category: Categories){
        do {
            try context.setValue("", forKey: "Categories")
        }catch{
            print("There was a problem while updating the category. \(error.localizedDescription)")
        }
    }
    
}

    //MARK:- TableView Delegate & DataSource Methods

extension MainView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categoriesArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = storyboard?.instantiateViewController(identifier: "ItemViewController") as! ItemViewController
        let currentCategory = categoriesArray[indexPath.row]
        destination.category = currentCategory
        navigationController?.pushViewController(destination, animated: true)
    }
}

