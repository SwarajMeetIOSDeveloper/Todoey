//
//  TodoListTableViewController.swift
//  Todoey
//
//  Created by Appolar on 29/10/18.
//  Copyright © 2018 Appolar. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {

    //MARK:- Variables
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
   
    
    //MARK:- Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Buy Eggos"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Destory Demogorgan"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Vola"
        itemArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }


    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title

        //Ternary Operator replace if else
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    

    // MARK: - Table view Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
      
    }
    
    //MARK:- Button Actions
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            newItem.done =  false
            
            print(textField.text!)
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
   

}
