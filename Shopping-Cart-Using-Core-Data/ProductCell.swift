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
        
        //Grab the text the user passes in as the name of the product
        cart.name = nameOfProductLabel.text
        
        // Set that value in the core data stack however the changes have not yet been made
        cart.setValue(nameOfProductLabel.text, forKey: "name")
    
        // Then save those changes due to the reason that we have to update the ui therefore we have to save the changes to the view context
        coreDataStack.saveTo(context: coreDataStack.viewContext)
        
        
    }
    
}
