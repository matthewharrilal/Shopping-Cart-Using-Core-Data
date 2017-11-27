//
//  CartTableViewController.swift
//  Shopping-Cart-Using-Core-Data
//
//  Created by Matthew Harrilal on 11/27/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CartTableViewController: UITableViewController {
    
    let coreDataStack = CoreDataStack.instance
    
    var cart_items = [Cart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetch = NSFetchRequest<Cart>(entityName: "Cart")
        do {
            let result = try coreDataStack.viewContext.fetch(fetch)
            self.cart_items = result
            self.tableView.reloadData()
        }
        catch {
            let nserror = error as NSError?
            print("Unresolved Error \(error), \(error.localizedDescription)")
        }
        for item in cart_items {
            print(item.name)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cart = cart_items[indexPath.row]
        cell.textLabel?.text = cart.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart_items.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // Confirm that the user is trying to delete the cell
        if editingStyle == .delete {
            // Get the appropiate item when the user is trying to delete the cell
            let cart = cart_items[indexPath.row]
            
            // Gain access to the view context
            let managedObjectContext = coreDataStack.viewContext
            
            // Delete the item that the user is trying to delete however changes have not been made to the core data stack therefore we have to save the changes
            managedObjectContext.delete(cart)
            
            do {
                // Save the changes we have made to the cart
                try managedObjectContext.save()
                
                // Reload the table view therefore we can see the reflected changes
                self.tableView.reloadData()
            }
            catch {
                
                // If there is an error then we want to see the error
                let nserror = error as NSError?
                print("Unresolved error trying to delete the item \(nserror), \(nserror?.localizedDescription)")
            }
        }
    }
}
