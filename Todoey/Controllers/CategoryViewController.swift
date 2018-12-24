//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Appolar on 13/11/18.
//  Copyright © 2018 Appolar. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    //MARK:- Variables
    let realm = try! Realm()
    
    
      var categories: Results<Category>?
    
    //MARK:- Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }

     //MARK:- TableView DataSource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryListCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        return cell

    }
    
     //MARK:- TableView Delegate Methods
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TodoListTableViewController") as! TodoListTableViewController
            vc.selectedCategory = categories?[indexPath.row]
    print(vc.selectedCategory!)
    self.navigationController?.pushViewController(vc, animated: true)
    
    }
   
    
    //MARK:- Button Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New category"
            textField = alertTextField
            
        }
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK:- User Defined Functions
    
    func save(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategories() {

        categories = realm.objects(Category.self)
        tableView.reloadData()


    }
    
}
