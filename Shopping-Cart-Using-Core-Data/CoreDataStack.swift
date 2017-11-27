//
//  CoreDataStack.swift
//  Shopping-Cart-Using-Core-Data
//
//  Created by Matthew Harrilal on 11/26/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import CoreData
import UIKit


public final class CoreDataStack {
    static let instance = CoreDataStack()
    
    // Creating the perisistent container to hold the managed object context
    private lazy var persistentContainer: NSPersistentContainer = {
        
        // The container we are creating goes by the name of Shopping Cart
        // MARK: TODO Why is the syntax like this?
        let container = NSPersistentContainer(name: "Shopping_Cart_Using_Core_Data")
        
        // MARK: TODO When do we define which store we want to use?
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            // Now that we have the container we now have to be able to send it to a persistent store
            if let error = error as NSError? {
                // If there is an error loading the persistent store crash and give me the error message
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        })
        
        // Now whenever this is called we now have the container that holds the managed object context we now have a store connected to it where the MOCS can be sent
        return container
    }()
    
    // Define where the and how the MOCs are being handled, this is the view context meaning that if we want to see it displayed on the ui we have to write the data to the view context
    lazy var viewContext: NSManagedObjectContext = {
        
        // Essentially what we are doing for the private context this does for us automatically
        let viewContext = persistentContainer.viewContext
        return viewContext
    }()
    
    // If we want to use the data in the background we are going to have to write it to the private context as well as put it on the private queue
    lazy var privateContext: NSManagedObjectContext = {
        
        // This is essentially declaring which context we are going to be writing to as well as the queue we are putting it on
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        // Connecting the private contexts peristent store coordinator to the persistent container persistents store coordinator
        privateContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return privateContext
    }()
    
    func saveTo(context: NSManagedObjectContext) {
        // Whatever changes we make to either of the contexts depending on our decision we have to save those changes to the contexts parent store meaning we are saving to the persistent store coordinator
        if context.hasChanges {
            do {
            print("The changes have been made to the contexts persistent store coordinator")
            try? context.save()
            }
            catch {
                let nserror = error as NSError?
                fatalError("Trouble saving the changes made to the context and the issue being \(nserror), \(nserror?.localizedDescription)")
            }
        }
        
    }
}
