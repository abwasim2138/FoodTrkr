//
//  MealTableViewController.swift
//  FoodTrkr
//
//  Created by Layla Nawawi on 9/23/15.
//  Copyright © 2015 Laylapp. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Properties 
    
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
        
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }else {
            loadSampleMeals()
        }
    }
    
    func loadSampleMeals() {
        
        let image1 = UIImage(named: "cookies")
        let meal1 = Meal(name: "Cookies", photo: image1, rating: 5)!
        
        let image2 = UIImage(named: "iceCream")
        let meal2 = Meal(name: "IceCream", photo: image2, rating: 4)!
        
        let image3 = UIImage(named: "pizza")
        let meal3 = Meal(name: "Pizza", photo: image3, rating: 3)!
        
        meals += [meal1, meal2, meal3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return meals.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            saveMeals()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)
                let selectedMeal = meals[indexPath!.row]
                mealDetailViewController.meal = selectedMeal
            }
        }else if segue.identifier == "AddItem" {
            print("Adding new meal.")
        }
        
        
    }

    
    @IBAction func undwindToMealList(sender: UIStoryboardSegue) {
        
       
            
        if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }else{
                
                // Add a new meal
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the meals.
            
            saveMeals()
        }
    }
    
    // MARK: NSCoding 
    
    func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func loadMeals () -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }

}
