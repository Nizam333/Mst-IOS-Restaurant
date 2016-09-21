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
    
    var results:NSArray = []
    
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
    
    var moc:NSManagedObjectContext = DataController().managedObjectContext
    
    
    @IBOutlet var lbl_Total: UILabel!
    
    @IBOutlet var btn_PlaceOrder: UIButton!
    @IBAction func Action_PlaceOrder(sender: AnyObject) {
    }
    var fetchedResultsController: NSFetchedResultsController?
  
    @IBOutlet var Action_Clear: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UIView.animateWithDuration(0.6 ,
                                   animations: {
                                    self.btn_PlaceOrder.transform = CGAffineTransformMakeScale(0.6, 0.6)
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.6){
                                        self.btn_PlaceOrder.transform = CGAffineTransformIdentity
                                    }
        })
        
        
        tabView.backgroundColor = UIColor.clearColor()
        
        
        title = "Cart List"
        do {
            
             moc = DataController().managedObjectContext
            
            self.fetchedResultsController = NSFetchedResultsController(fetchRequest: self.allCartFetchRequest(), managedObjectContext: DataController().managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            self.fetchedResultsController?.delegate = self
            //self.fetchedResultsController?.performFetch(nil)
            try self.fetchedResultsController?.performFetch()
            
           calculateTotalPrice()
        }catch{
            print(error)
        }
    }
    
    
    

    func calculateTotalPrice()  {
         do {
        var fetchRequest = self.allCartFetchRequest()
        fetchRequest.returnsObjectsAsFaults = false;
         results = try DataController().managedObjectContext.executeFetchRequest(fetchRequest)
            
            //assignments = results as! [CartEntity]
        
        var Total_all: Double = 0
        for res in results {
            var price = Double(res.valueForKey("pro_rate") as! String)
            var qty = Double(res.valueForKey("pro_qty") as! NSInteger)
           // var total = qty*price!
            print("total = \(price)")
            
            
            
            Total_all += price!
        }
        
            self.lbl_Total.text = "$ "+String(Total_all)
        print("Total Sum = \(Total_all)")
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
        productCell.backgroundColor = UIColor.clearColor()
        //let product = CartManager.sharedInstance.productAtIndexPath(indexPath)
        //let product = ProductObject()
        
        
        
        //productCell.itemName.text = itemTitle[indexPath.row]
        
        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
            // print(error)
        }
        //let TrPlus = UITapGestureRecognizer(target:self, action: Selector(self.ActionPlus()))
        //let TrMinus = UITapGestureRecognizer(target:self, action:Selector(self.ActionMinus()))
        
        
        /*productCell.img_plus.tag = indexPath.row
        productCell.img_minus.tag = indexPath.row
        
         productCell.img_plus.addTarget(self, action: "ActionPlus:", forControlEvents: .TouchUpInside)
         productCell.img_minus.addTarget(self, action: "ActionMinus:", forControlEvents: .TouchUpInside)*/
        
        
       // productCell.img_plus.addGestureRecognizer(TrPlus)
       // productCell.img_minus.addGestureRecognizer(TrMinus)
       

        if let cellContact = fetchedResultsController?.objectAtIndexPath(indexPath) as? CartEntity {
            productCell.itemName.text = cellContact.pro_name
            productCell.itemPrice.text = "$ "+cellContact.pro_rate!
            productCell.itemQty.text = String(cellContact.pro_qty)
            productCell.configureWithValue(UInt(cellContact.pro_qty), incrementHandler: incrementHandler(), decrementHandler: decrementHandler())
            
            let url = NSURL(string: cellContact.pro_image!)
            print(url)
            productCell.itemImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "navheader"), completed: block)
            
        }
        
        
        
        
        //let url = NSURL(string: self.arr_image[indexPath.row])
        //print(url)
        
       // cell.itemImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "navheader"), completed: block)
        
        
        productCell.contentView.backgroundColor = UIColor.clearColor()
        
        let whiteRoundedView : UIView = UIView(frame: CGRectMake(10, 8, self.view.frame.size.width - 0, 149))
        
        whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 0.8])
        whiteRoundedView.layer.masksToBounds = true
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        productCell.contentView.addSubview(whiteRoundedView)
        productCell.contentView.sendSubviewToBack(whiteRoundedView)
        
        productCell.layer.shouldRasterize = true
        productCell.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        
        return productCell
    }
    private func incrementHandler() -> ButtonHandler {
        return { [unowned self] CartProductViewCell in
            guard let row = self.tabView.indexPathForCell(CartProductViewCell)?.row else { return }
            
            
            print("increment handler interface")
            
            let person = self.results[row] as! NSManagedObject
            
            
            var price = person.valueForKey(Key().cE_pro_rate) as! String
            var qty = person.valueForKey(Key().cE_pro_qty) as! Int
            
            var price_Per_qty = Double(price)! / Double(qty)
            qty = qty + 1
            person.setValue(qty, forKey: Key().cE_pro_qty)
            
            
            var total = price_Per_qty * Double(qty)
            print("price total = \(total)")
            person.setValue(String(total), forKey: Key().cE_pro_rate)
            // we save our entity
            do {
                
                try person.managedObjectContext?.save()
                //try self.moc.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
            self.reloadCellAtRow(row)
        }
    }
    
    
    
    private func decrementHandler() -> ButtonHandler {
        
        
            return { [unowned self] CartProductViewCell in
            guard let row = self.tabView.indexPathForCell(CartProductViewCell)?.row else { return }
            
            
            print("increment handler interface")
            
            let person = self.results[row] as! NSManagedObject
                
                
            var price = person.valueForKey(Key().cE_pro_rate) as! String
            var qty = person.valueForKey(Key().cE_pro_qty) as! Int
                
            
           
            if qty > 1 {
                
                var price_Per_qty = Double(price)! / Double(qty)
                 qty = qty - 1
                 person.setValue(qty, forKey: Key().cE_pro_qty)
                
                
                var total = price_Per_qty * Double(qty)
                print("price total = \(total)")
                person.setValue(String(total), forKey: Key().cE_pro_rate)
                
                do {
                    
                    try person.managedObjectContext?.save()
                    //try self.moc.save()
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
                
                self.reloadCellAtRow(row)
            }
            else { return }
           
            
        }
    }
    
    private func reloadCellAtRow(row: Int) {
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        
        //calculateTotalPrice()
        tabView.beginUpdates()
        tabView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tabView.endUpdates()
    }
    
    func ActionPlus(sender:UIButton){
        
        UIView.animateWithDuration(0.6 ,
                                   animations: {
                                    sender.transform = CGAffineTransformMakeScale(0.3, 0.3)
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.2){
                                        sender.transform = CGAffineTransformIdentity
                                        //sender.setImage(UIImage(named: "minus"), forState: UIControlState.Normal)
                                    }
        })
        
        
       /* let productCell = tabView.dequeueReusableCellWithIdentifier("IdcartList") as! CartProductViewCell
        
        productCell.itemQty.tag = sender.tag
        productCell.itemQty.text = "123" */
        
        
    print("plus tapped \(sender.tag)")
        print("plus tapped")
    }
    func ActionMinus(sender:UIButton){
    print("minus tapped \(sender.tag)")
        
        UIView.animateWithDuration(0.6 ,
                                   animations: {
                                    sender.transform = CGAffineTransformMakeScale(0.3, 0.3)
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.2){
                                        sender.transform = CGAffineTransformIdentity
                                        //sender.setImage(UIImage(named: "minus"), forState: UIControlState.Normal)
                                    }
        })
        
        let tag:NSInteger = sender.tag;
        let indexPath = NSIndexPath(forRow: tag, inSection: 0)
        let productCell = tabView.dequeueReusableCellWithIdentifier("IdcartList") as! CartProductViewCell
        
        productCell.itemQty.tag = tag
        productCell.itemQty.text = "123"
    }
   
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        }
        
        switch editingStyle {
        case .Delete:
            
            do {
                //reference to our app delegate
               // let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
                let context: NSManagedObjectContext = DataController().managedObjectContext
                
                let person = self.results[indexPath.row] as! NSManagedObject
                
                
                var proID = person.valueForKey(Key().cE_pro_id) as! String
                
                print("proID  = \(proID)")
                
                let request = NSFetchRequest(entityName: "CartEntity")
                request.includesSubentities = false
                request.returnsObjectsAsFaults = false
                
                request.predicate = NSPredicate(format: "pro_id == %@", proID)
               let itemss = try DataController().managedObjectContext.executeFetchRequest(request) as! NSManagedObject
                
                print("predicate result = \(itemss)")
                
                for item in itemss {
                    
                    var deleteUserError: NSError?
                    
                    DataController().managedObjectContext.deleteObject(item)
                    DataController().managedObjectContext.save(&deleteUserError)
                }
                
                
                //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
            //DataController().managedObjectContext.deleteObject(fetchedResultsController?.objectAtIndexPath(indexPath) as! CartEntity)
            //try DataController().managedObjectContext.save()
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
