//
//  TableOfElements.swift
//  TableOfElements
//
//  Created by Lance Matysik on 3/1/16.
//  Copyright © 2016 Lance Matysik. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TableOfElementsController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!

    var fetchResults = []
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Element")
        let sectionSortDescriptor = NSSortDescriptor(key: "atomicNumber", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        if let results = try? managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject] {
            fetchResults = results
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResults.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? ElementsCollectionViewCelll
        
        if let colorString = fetchResults[indexPath.row].valueForKey("cpkHexColor") as? String {
            if colorString != "" {
                cell?.backgroundColor = UIColor(hexString: "#" + colorString)
            } else {
                cell?.backgroundColor = UIColor.whiteColor()
            }
        }
        
        cell?.name.text = fetchResults[indexPath.row].valueForKey("symbol") as? String
        cell?.fullName.text = fetchResults[indexPath.row].valueForKey("name") as? String
        cell?.weight.text = fetchResults[indexPath.row].valueForKey("atomicMass") as? String
        cell?.atomic.text = "\(fetchResults[indexPath.row].valueForKey("atomicNumber")!)"
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueForDetail") {
            let cell = sender as! UICollectionViewCell
            let indexPath = self.collectionView.indexPathForCell(cell)
            let result = segue.destinationViewController as! DetailViewController
            
            var longResultString = "\(fetchResults[indexPath!.row].valueForKey("symbol")!) \n"
            longResultString += "Name: \(fetchResults[indexPath!.row].valueForKey("name")!) \n"
            longResultString += "Atomic Number: \(fetchResults[indexPath!.row].valueForKey("atomicNumber")!) \n"
            longResultString += "Group: \(fetchResults[indexPath!.row].valueForKey("group")!)".capitalizedString + "\n"
            
            if fetchResults[indexPath!.row].valueForKey("atomicMass") != nil {
                longResultString += "Atomic Mass: \(fetchResults[indexPath!.row].valueForKey("atomicMass")!)".truncate(18) + "\n"
            } else {
                longResultString += "Atomic Mass: NA \n"
            }
            
            if fetchResults[indexPath!.row].valueForKey("standardState")?.stringValue != "" {
                longResultString += "Standard State: \(fetchResults[indexPath!.row].valueForKey("standardState")!)".capitalizedString + "\n"
            } else {
                longResultString += "Standard State: NA \n"
            }
            
            if fetchResults[indexPath!.row].valueForKey("bondingType")?.stringValue != "" {
                longResultString += "Bonding Type: \(fetchResults[indexPath!.row].valueForKey("bondingType")!)".capitalizedString + "\n"
            } else {
                longResultString += "Bonding Type: NA \n"
            }
            
            if fetchResults[indexPath!.row].valueForKey("boilingPoint") != nil {
                longResultString += "Boiling Point: \(fetchResults[indexPath!.row].valueForKey("boilingPoint")!) K \n"
            } else {
                longResultString += "Boiling Point: NA \n"
            }
            
            if fetchResults[indexPath!.row].valueForKey("meltingPoint") != nil {
                longResultString += "Melting Point: \(fetchResults[indexPath!.row].valueForKey("meltingPoint")!) K \n"
            } else {
                longResultString += "Melting Point: NA \n"
            }
            
            longResultString += "Electron Configuration: \(fetchResults[indexPath!.row].valueForKey("electronConfiguration")!) \n"
            longResultString += "Date Discovered: \(fetchResults[indexPath!.row].valueForKey("dateDiscovered")!)"
            result.recieved = longResultString
        }
    }
    
}