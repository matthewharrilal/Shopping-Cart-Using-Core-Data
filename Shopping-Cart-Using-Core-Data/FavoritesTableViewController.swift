//
//  FavoritesTableViewController.swift
//  Shopping-Cart-Using-Core-Data
//
//  Created by Matthew Harrilal on 11/27/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController {
    
    let coreDataStack = CoreDataStack.instance
    
    var favorites = [Favorites]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetch = NSFetchRequest<Favorites>(entityName: "Favorites")
        do {
            let result = try coreDataStack.viewContext.fetch(fetch)
            self.favorites = result
            
            self.tableView.reloadData()
        }
        catch {
            let nserror = error as NSError?
             ("Unresolved error failure to favorite item \(nserror), \(nserror?.localizedDescription)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let favorite = favorites[indexPath.row]
        cell.textLabel?.text = favorite.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
}
