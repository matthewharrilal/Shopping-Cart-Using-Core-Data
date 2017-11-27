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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
}
