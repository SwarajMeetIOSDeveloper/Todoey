//
//  TodoListTableViewController.swift
//  Todoey
//
//  Created by Appolar on 29/10/18.
//  Copyright © 2018 Appolar. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListTableViewController: UITableViewController{

    //MARK:- Variables
    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category?{
        didSet{
             self.loadItems()
        }
        
    }
    

    
    //MARK:- Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            //Ternary Operator replace if else
            cell.accessoryType = item.done ? .checkmark : .none
            
        }else{
            cell.textLabel?.text = "No Items Added"
        }
       
        
        return cell
    }
    

    // MARK: - Table view Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            do {
                try realm.write {
 //                   realm.delete(item)
            
                }
            }catch{
                print("Error saving done status,\(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
      
    }
    
    //MARK:- Button Actions
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory{
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items \(error)")
                }
            }
            
           self.tableView.reloadData()
          
        
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK:- User Defined Functions
    
//    func saveItems(){
//
//        do {
//           try context.save()
//        } catch {
//           print("Error saving context\(error)")
//        }
//        self.tableView.reloadData()
//    }
    
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()


    }
    
}

  //MARK:- SearchBar Methods
extension TodoListTableViewController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          print(searchBar.text!)
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    

//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//         request.predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
//
//         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//         loadItems(with: request)

    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {


        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }



    }
}
