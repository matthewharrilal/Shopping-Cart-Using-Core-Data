//
//  DisplayProductsViewController.swift
//  Shopping-Cart-Using-Core-Data
//
//  Created by Matthew Harrilal on 11/26/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DisplayProducts: UITableViewController {
    let coreDataStack = CoreDataStack.instance
    var products = [Products]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetch = NSFetchRequest<Products>(entityName: "Products")
        do {
            let result = try coreDataStack.viewContext.fetch(fetch)
            self.products = result
            self.tableView.reloadData()
        }
        catch {
            let nserror = error as NSError?
            print("Unable to fetch the results from core data \(error), \(error.localizedDescription)")
        }
        
        print("These are the products \(products)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        cell.nameOfProductLabel?.text = product.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Gaining access the the data in the view context of our core data stack
            let managedObjectContext = coreDataStack.viewContext
            
            // Now that we have access we also have to gain access to the cell that the user is trying to delete
            let product = products[indexPath.row]
            
            // Now that we have the cell the user is trying to delete we then have to delete from core data
            managedObjectContext.delete(product)
            
            do {
                //Have to save the changes we made to the managed object context
                try managedObjectContext.save()
                self.tableView.reloadData()
            }
            catch {
                // If there is an error we want to see what the error is
                let nserror = error as NSError?
                print("Error deleting the product \(nserror), \(nserror?.localizedDescription)")
            }
        }
    }
}
