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
    
   
    
    var moc:NSManagedObjectContext = DataController().managedObjectContext
    
    var frc: NSFetchedResultsController = NSFetchedResultsController()
    
    
    @IBOutlet var lbl_Total: UILabel!
    
    @IBOutlet var btn_PlaceOrder: UIButton!
    @IBAction func Action_PlaceOrder(sender: AnyObject) {
    }
    
    @IBAction func Action_Clear(sender: AnyObject) {
        
        deleteAllData()
    }
    
    
    var fetchedResultsController: NSFetchedResultsController?
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: allCartFetchRequest(), managedObjectContext: DataController().managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
  
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
        
        
        self.firstTableLoad()
    }
    
    func firstTableLoad(){
        do {
            
            moc = DataController().managedObjectContext
            
            self.fetchedResultsController = NSFetchedResultsController(fetchRequest: self.allCartFetchRequest(), managedObjectContext: DataController().managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            self.fetchedResultsController?.delegate = self
            
            try self.fetchedResultsController?.performFetch()
            
            frc = fetchedResultsController!
             results = frc.fetchedObjects!
            
            calculateTotalPrice()
        }catch{
            print(error)
        }
    
    }
    
    

    func calculateTotalPrice()  {
         do {
        
            results = frc.fetchedObjects!
        var Total_all: Double = 0
        for res in results {
            let price = Double(res.valueForKey("pro_rate") as! String)
           // let qty = Double(res.valueForKey("pro_qty") as! NSInteger)
            //var total = qty*price!
            print("total = \(price)")
            
            
            
            Total_all += price!
        }
        
            self.lbl_Total.text = "$ "+String(Total_all)
        print("Total Sum = \(Total_all)")
         }
    }
    
   
    
    func allCartFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "CartEntity")
        let sortDescriptor = NSSortDescriptor(key: "pro_name", ascending: true)
        
        fetchRequest.predicate = nil
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 20
        
        return fetchRequest
    }
    func deleteAllData() {
        
        do{
        let context = DataController().managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "CartEntity")
        fetchRequest.includesPropertyValues = false
        if let fetchResults = try context.executeFetchRequest(fetchRequest) as? [CartEntity] {
            
            for result in fetchResults {
                context.deleteObject(result)
            }
            
        }
       try context.save()
            dispatch_async(dispatch_get_main_queue()) {
                
                self.firstTableLoad()
                self.tabView.reloadData()
            }
 
            
        }catch{
        print(error)
        }
    }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return (frc.fetchedObjects?.count)! //frc.sections?[section].numberOfObjects ?? 0
    }
   
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCellWithIdentifier("IdcartList") as! CartProductViewCell
        productCell.backgroundColor = UIColor.clearColor()
        
        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
           
        }
        
        let cellContact = results.objectAtIndex(indexPath.row) as! CartEntity


      
            productCell.itemName.text = cellContact.pro_name
            productCell.itemPrice.text = "$ "+cellContact.pro_rate!
            productCell.itemQty.text = String(cellContact.pro_qty)
            productCell.configureWithValue(UInt(cellContact.pro_qty), incrementHandler: incrementHandler(), decrementHandler: decrementHandler())
            
            let url = NSURL(string: cellContact.pro_image!)
            print(url)
            productCell.itemImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "navheader"), completed: block)
            
        
    
        
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
            
            
            let price = person.valueForKey(Key().cE_pro_rate) as! String
            var qty = person.valueForKey(Key().cE_pro_qty) as! Int
            
            let price_Per_qty = Double(price)! / Double(qty)
            qty = qty + 1
            person.setValue(qty, forKey: Key().cE_pro_qty)
            
            
            let total = price_Per_qty * Double(qty)
            print("price total = \(total)")
            person.setValue(String(total), forKey: Key().cE_pro_rate)
            // we save our entity
            do {
                
                try person.managedObjectContext?.save()
                
              
                self.reloadCellAtRow(row)
                
               
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
            
        }
    }
    
    
    
    private func decrementHandler() -> ButtonHandler {
        
        
            return { [unowned self] CartProductViewCell in
            guard let row = self.tabView.indexPathForCell(CartProductViewCell)?.row else { return }
            
            
            print("increment handler interface")
            
            let person = self.results[row] as! NSManagedObject
                
                
            let price = person.valueForKey(Key().cE_pro_rate) as! String
            var qty = person.valueForKey(Key().cE_pro_qty) as! Int
                
            
           
            if qty > 1 {
                
                let price_Per_qty = Double(price)! / Double(qty)
                 qty = qty - 1
                 person.setValue(qty, forKey: Key().cE_pro_qty)
                
                
                let total = price_Per_qty * Double(qty)
                print("price total = \(total)")
                person.setValue(String(total), forKey: Key().cE_pro_rate)
                
                do {
                    
                    try person.managedObjectContext?.save()
                    self.reloadCellAtRow(row)
                   
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
                
                
            }
            else {
                
                do {
                    
                    let proID = person.valueForKey(Key().cE_pro_id) as! String
                    
                    print("proID  = \(proID)")
                    
                    let request = NSFetchRequest(entityName: "CartEntity")
                    request.includesSubentities = false
                    request.returnsObjectsAsFaults = false
                    
                    request.predicate = NSPredicate(format: "pro_id == %@", proID)
                    
                    
                    
                    if let fetchResults = try person.managedObjectContext!.executeFetchRequest(request) as? [CartEntity] {
                        print("predicate result = \(fetchResults)")
                        
                        for itemm in fetchResults {
                            
                            person.managedObjectContext!.deleteObject(itemm)
                            try person.managedObjectContext!.save()
                            
                            
                            self.deleteRow(row)
                        }
                    }
                    
                }catch{
                    print(error)
                    
                }
                
                }
           
            
        }
    }
    
   
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        }
        
        switch editingStyle {
        case .Delete:
            
            do {
               
                let context: NSManagedObjectContext = DataController().managedObjectContext
                
                let person = self.results[indexPath.row] as! NSManagedObject
                
                
                let proID = person.valueForKey(Key().cE_pro_id) as! String
                
                print("proID  = \(proID)")
                
                let request = NSFetchRequest(entityName: "CartEntity")
                request.includesSubentities = false
                request.returnsObjectsAsFaults = false
                
                request.predicate = NSPredicate(format: "pro_id == %@", proID)
               
                
                
                if let fetchResults = try context.executeFetchRequest(request) as? [CartEntity] {
                    print("predicate result = \(fetchResults)")
            
                    for itemm in fetchResults {
                        
                        context.deleteObject(itemm)
                        try context.save()
                        self.deleteRow(indexPath.row)
                    }
                }
           
            }catch{
            print(error)
            
            }
            
            
        case .Insert:
            break
        case .None:
            break
        }
        
    }
    
    private func deleteRow(row: Int){
   
        self.firstTableLoad()
        tabView.reloadData()
        
    }
    
    private func reloadCellAtRow(row: Int) {
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        
        self.firstTableLoad()
       
        tabView.beginUpdates()
        tabView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tabView.endUpdates()
        
    }
    
    
   
    
   
    
   
   
}
