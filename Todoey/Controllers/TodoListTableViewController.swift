//
//  TodoListTableViewController.swift
//  Todoey
//
//  Created by Appolar on 29/10/18.
//  Copyright © 2018 Appolar. All rights reserved.
//

import UIKit
import CoreData

class TodoListTableViewController: UITableViewController{

    //MARK:- Variables
    var itemArray = [Item]()
    var selectedCategory : Category?{
        didSet{
            self.loadItems()
        }
        
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
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
    
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
         self.saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
      
    }
    
    //MARK:- Button Actions
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            
            let newItem = Item(context: self.context)
          
            newItem.title = textField.text!
            newItem.done =  false
            newItem.parentCategory = self.selectedCategory
            print(newItem.parentCategory)
          
            
            print(textField.text!)
            self.itemArray.append(newItem)
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.saveItems()
          
        
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK:- User Defined Functions
    
    func saveItems(){
        
        do {
           try context.save()
        } catch {
           print("Error saving context\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let addtionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,addtionalPredicate])
        }else{
            request.predicate = categoryPredicate
        }
        do{
           itemArray = try context.fetch(request)
        }catch{
            print("Error In fetchng data from Context\(error)")
        }
        tableView.reloadData()
       
        
    }
    
}

//MARK:- SearchBar Methods
extension TodoListTableViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
         request.predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
        
         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
         loadItems(with: request)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
  
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }   
            
        }
        
       
        
    }
}
