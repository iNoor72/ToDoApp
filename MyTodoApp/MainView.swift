//
//  ViewController.swift
//  MyTodoApp
//
//  Created by Noor Walid on 11/16/20.
//

import UIKit
import CoreData

class MainView: UIViewController {
    

    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).CoreDataDatabase.viewContext
    
    var categories = [Categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.backButtonTitle = "Categories"
        categoryTextField.resignFirstResponder()
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if let categoryName = categoryTextField.text {
            let newCategory = Categories(context: context)
            newCategory.name = categoryName
            categories.append(newCategory)
            savingContext()
            getCategories()
        }
    }
    
    
    //MARK:- Core Data Functions
    
    func getCategories() {
        do {
            categories = try context.fetch(Categories.fetchRequest())
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
    
}

    //MARK:- TableView Delegate & DataSource Methods

extension MainView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = storyboard?.instantiateViewController(identifier: "ItemViewController") as! ItemViewController
        let currentCategory = categories[indexPath.row]
        destination.category = currentCategory
        navigationController?.pushViewController(destination, animated: true)
    }
}

