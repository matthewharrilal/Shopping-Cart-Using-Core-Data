//
//  ProductCell.swift
//  Shopping-Cart-Using-Core-Data
//
//  Created by Matthew Harrilal on 11/27/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import CoreData
     
class ProductCell: UITableViewCell {
    
    
    
    let coreDataStack = CoreDataStack.instance
    
    @IBOutlet weak var nameOfProductLabel: UILabel!
    
    @IBAction func addToCartButton(_ sender: AnyObject) {
        let fetchRequest = NSFetchRequest<Products>(entityName: "Cart")
        let displayProducts = DisplayProducts()
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: displayProducts.tableView)
        let indexPath = displayProducts.tableView.indexPathForRow(at: buttonPosition)
        let currentProduct = displayProducts.products[(indexPath?.row)!]
        print(currentProduct.name)
        
    }
    
    @IBAction func favoriteProduct(_ sender: Any) {
        // Gives the ability to a user to be able to favorite items
        let favorite = Favorites(context: coreDataStack.viewContext)
        
        favorite.name = nameOfProductLabel.text
        
        print("This is the value for the key name : \(favorite.value(forKey: "name"))")
        
        favorite.setValue(nameOfProductLabel.text, forKey: "name")
        
        
        if favorite.value(forKey: "name") == nil {
        coreDataStack.saveTo(context: coreDataStack.viewContext)
        
        }
    }
}
