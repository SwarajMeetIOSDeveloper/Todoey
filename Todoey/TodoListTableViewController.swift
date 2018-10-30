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
    var itemArray = ["Find Mike", "Buy Eggs", "Destroy Demogorgan"]
   
    
    //MARK:- Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()


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

        cell.textLabel?.text = itemArray[indexPath.row]

        return cell
    }
    

    // MARK: - Table view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print("\((indexPath.row) + 1)" + "." + itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
      
    }
    
    //MARK:- Button Actions
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            print(textField.text!)
            self.itemArray.append(textField.text!)
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
