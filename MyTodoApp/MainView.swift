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
    let context = (UIApplication.shared.delegate as! AppDelegate).CoreDataDatabase.viewContext
    var items = [Item]()
    var categories = Categories()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if let newItem = itemTextField.text {
            items.append(Item(context: context))
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            //Add to Core Data
        }
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
//        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row].name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = storyboard?.instantiateViewController(identifier: "") as! ItemViewController
        //destination.title = categories.items[indexPath.row].name
    }

    
}

