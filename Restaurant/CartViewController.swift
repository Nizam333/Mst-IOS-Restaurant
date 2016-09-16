//
//  CartViewController.swift
//  Restaurant
//
//  Created by Nizamuddeen on 9/14/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//
import UIKit
import Foundation
import CoreData
import SDWebImage

class CartViewController: UIViewController, UITableViewDataSource,  UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    
    @IBOutlet var tabView: UITableView!
    
    
    let itemTitle=[
    "Chicken",
    "Mutton",
    "Veg","Beverage",
    "Chowder",
    "Grill","Roast",
    "Jamal",
    "Macroni","Almtluth",
    "Meat",
    "sweets"
    ]
    
    
    
    var fetchedResultsController: NSFetchedResultsController?
  
    @IBOutlet var Action_Clear: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cart List"
        do {
            self.fetchedResultsController = NSFetchedResultsController(fetchRequest: self.allCartFetchRequest(), managedObjectContext: DataController().managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            self.fetchedResultsController?.delegate = self
            //self.fetchedResultsController?.performFetch(nil)
            try self.fetchedResultsController?.performFetch()
        }catch{
            print(error)
        }
    }
    
   
    
    func allCartFetchRequest() -> NSFetchRequest {
        
        var fetchRequest = NSFetchRequest(entityName: "CartEntity")
        let sortDescriptor = NSSortDescriptor(key: "pro_name", ascending: true)
        
        fetchRequest.predicate = nil
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 20
        
        return fetchRequest
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return itemTitle.count
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
   /* func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected indexpath \(indexPath.row)")
    }*/

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCellWithIdentifier("IdcartList") as! CartProductViewCell
        
        //let product = CartManager.sharedInstance.productAtIndexPath(indexPath)
        //let product = ProductObject()
        
        
        
        //productCell.itemName.text = itemTitle[indexPath.row]
        
        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
            // print(error)
        }
        //let TrPlus = UITapGestureRecognizer(target:self, action: Selector(self.ActionPlus()))
        //let TrMinus = UITapGestureRecognizer(target:self, action:Selector(self.ActionMinus()))
        productCell.img_plus.tag = indexPath.row
        productCell.img_minus.tag = indexPath.row
        productCell.img_plus.addTarget(self, action: "ActionPlus:", forControlEvents: .TouchUpInside)
         productCell.img_minus.addTarget(self, action: "ActionMinus:", forControlEvents: .TouchUpInside)
       // productCell.img_plus.addGestureRecognizer(TrPlus)
       // productCell.img_minus.addGestureRecognizer(TrMinus)
       

        if let cellContact = fetchedResultsController?.objectAtIndexPath(indexPath) as? CartEntity {
            productCell.itemName.text = cellContact.pro_name
            productCell.itemPrice.text = cellContact.pro_rate
            
            let url = NSURL(string: cellContact.pro_image!)
            print(url)
            productCell.itemImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "navheader"), completed: block)
            
        }
        
        
        //let url = NSURL(string: self.arr_image[indexPath.row])
        //print(url)
        
       // cell.itemImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "navheader"), completed: block)
        
        productCell.layer.shouldRasterize = true
        productCell.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        
        return productCell
    }
    func ActionPlus(sender:UIButton){
        
        
    print("plus tapped \(sender.tag)")
        print("plus tapped")
    }
    func ActionMinus(sender:UIButton){
    print("minus tapped \(sender.tag)")
    }
   
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        }
        
        switch editingStyle {
        case .Delete:
            
            do {
            DataController().managedObjectContext.deleteObject(fetchedResultsController?.objectAtIndexPath(indexPath) as! CartEntity)
            try DataController().managedObjectContext.save()
            }catch{
            print(error)
            
            }
        case .Insert:
            break
        case .None:
            break
        }
        
    }
    //MARK: NSFetchedResultsController Delegate Functions
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case NSFetchedResultsChangeType.Insert:
            tabView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Fade)
            break
        case NSFetchedResultsChangeType.Delete:
            tabView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Fade)
            break
        case NSFetchedResultsChangeType.Move:
            break
        case NSFetchedResultsChangeType.Update:
            break
        default:
            break
        }
    }
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case NSFetchedResultsChangeType.Insert:
            tabView.insertRowsAtIndexPaths(NSArray(object: newIndexPath!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            break
        case NSFetchedResultsChangeType.Delete:
            tabView.deleteRowsAtIndexPaths(NSArray(object: indexPath!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            break
        case NSFetchedResultsChangeType.Move:
            tabView.deleteRowsAtIndexPaths(NSArray(object: indexPath!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            tabView.insertRowsAtIndexPaths(NSArray(object: newIndexPath!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            break
        case NSFetchedResultsChangeType.Update:
            tabView.cellForRowAtIndexPath(indexPath!)
            break
        default:
            break
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tabView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tabView.endUpdates()
    }
   
   
    
   
   
}
