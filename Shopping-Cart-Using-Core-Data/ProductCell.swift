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
    
    @IBAction func addToCartButton(_ sender: UIButton) {
        // When the user taps on the add to cart button the item gets added to the cart
        let cart = Cart(context: coreDataStack.viewContext)
        cart.name = nameOfProductLabel.text
        
        cart.setValue(nameOfProductLabel.text, forKey: "name")
        
        coreDataStack.saveTo(context: coreDataStack.viewContext)
    }
    
}
