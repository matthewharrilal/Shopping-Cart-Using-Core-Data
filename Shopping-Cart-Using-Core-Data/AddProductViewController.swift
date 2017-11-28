//
//  ViewController.swift
//  Shopping-Cart-Using-Core-Data
//
//  Created by Matthew Harrilal on 11/26/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//
import Foundation
import CoreData
import UIKit

class AddProductViewController: UIViewController {
    
    // Access the one and only instance we made of the core data stack instance
    let coreDataStack = CoreDataStack.instance
    
    @IBOutlet weak var nameOfProductTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func seeProductsButton(_ sender: Any) {
        self.performSegue(withIdentifier: "displayProducts", sender: nil)
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
        
        // Hold the name of the product in a variable
        guard let productName = nameOfProductTextField.text else {return}
        
        // We are access the attributes of the Product Entity on the private queue because we do not need any ui updates
        let product = Products(context: coreDataStack.viewContext)
        
        // Set the value of the attribute equal to the name the user passed in as the name of the product
        product.name = productName
        
        // Then once we update that attribute value then set that value in core data
        product.setValue(productName, forKey: "name")
        
        
        // When set then save those changes to the view context because we are going to want to display that data or the name of the product on the cell
        coreDataStack.saveTo(context: coreDataStack.viewContext)
        
                
        self.performSegue(withIdentifier: "displayCart", sender: nil)
        
    }
    
}

