//
//  ViewController.swift
//  ToDoList
//
//  Created by fatma y on 11.05.2023.
//

import UIKit
import RealmSwift

class TodolistViewController: UITableViewController {
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
           loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    
    //MARK: Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            // value = condition ? valueIfTrue: valueIfFalse
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell

    }
    
    //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //Removing an item when clicked
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
       // todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        
       // saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add New Items
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do List Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving category \(error)")
                }
            }
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Model Manipulation Methods
    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    
}

//MARK: Search Bar methods

// extension TodolistViewController: UISearchBarDelegate {
//
//     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//         let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//         let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//         request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//         loadItems(with: request, predicate: predicate)
//
//     }
//
//     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//         if searchBar.text?.count == 0 {
//             loadItems()
//
//             DispatchQueue.main.async {
//                 searchBar.resignFirstResponder()
//             }
//
//         }
//     }
// }

