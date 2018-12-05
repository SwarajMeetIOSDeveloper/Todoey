//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Appolar on 13/11/18.
//  Copyright © 2018 Appolar. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    //MARK:- Variables
      var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryListCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell

    }
    
     //MARK:- TableView Delegate Methods
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TodoListTableViewController") as! TodoListTableViewController
            vc.selectedCategory = categoryArray[indexPath.row]
            print(vc.selectedCategory)
    self.navigationController?.pushViewController(vc, animated: true)
    
    }
   
    
    //MARK:- Button Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategories()
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New category"
            textField = alertTextField
            
        }
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK:- User Defined Functions
    
    func saveCategories(){
        
        do {
            try context.save()
        } catch {
            print("Error saving category\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category .fetchRequest()) {
        
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Error In fetchng data from Context\(error)")
        }
        tableView.reloadData()
        
        
    }
    
}
