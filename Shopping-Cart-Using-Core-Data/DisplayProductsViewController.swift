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
    var products = [Products]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetch = NSFetchRequest<Products>(entityName: "Products")
        do {
            let result = try coreDataStack.viewContext.fetch(fetch)
            self.products = result
            print(result)
            self.tableView.reloadData()
        }
        catch {
            let nserror = error as NSError?
            print("Unable to fetch the results from core data \(error), \(error.localizedDescription)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
