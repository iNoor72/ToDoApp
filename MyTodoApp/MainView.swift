//
//  ViewController.swift
//  MyTodoApp
//
//  Created by Noor Walid on 11/16/20.
//

import UIKit
import CoreData

class MainView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.isNavigationBarHidden = true
    }
    
    var categories = [Categories]()
    var items = [ToDoItem]()
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if let newItem = itemTextField.text {
            items.append(ToDoItem(name: newItem))
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            //Add to Core Data
        }
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row].name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = storyboard?.instantiateViewController(identifier: "") as! ItemViewController
        destination.title = categories[indexPath.row].name
    }

    
}

