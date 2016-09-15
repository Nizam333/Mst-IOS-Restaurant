//
//  MenuViewController.swift
//  Restaurant
//
//  Created by Suriya on 7/22/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import CoreData

class MenuViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
   // @IBOutlet var navitem: UIBarButtonItem!
    
    var cf = CommonFunction()
    
    //var cartValue:String = "0"
    var cartValue :Int = 22
    
    var catId:String?
    var catName:String?
    
   // var tab_title:String?
    
    // MARK: - UICollectionViewDataSource protocol
    var dataRows = NSArray()
    
    var arr_name:[String] = []
    var arr_proid:[String] = []
    var arr_catid:[String] = []
    var arr_rate:[String] = []
    var arr_desc:[String] = []
    var arr_image:[String] = []
    
    
    var name:[String] = []
    var rate:[String] = []
    var image:[String] = []
    
    
    var swiftImages:[UIImage] = []
    
    //var po = ProductObject.self
    
    

    
    /*let itemTitle=[
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
    
    let itemprice=["30","40","50","20","10","23","34","56","76","65","43","21"]
    
    let iimage=[UIImage(named:"nizam"),UIImage(named:"jamal"),UIImage(named:"mansoor"),UIImage(named:"nizam"),UIImage(named:"jamal"),UIImage(named:"mansoor"),UIImage(named:"nizam"),UIImage(named:"jamal"),UIImage(named:"mansoor"),UIImage(named:"nizam"),UIImage(named:"jamal"),UIImage(named:"mansoor")]*/
    
    
    @IBOutlet var tabView: UITableView!
   
    @IBOutlet var navItm: UIBarButtonItem!
        
   //let badgeButton : MIBadgeButton = MIBadgeButton(frame: CGRectMake(20, 20, 36, 36))
    
    
    override func viewWillAppear(animated: Bool) {
        
        //self.tabBarItem.title = "gfdsg"
        print("cayId............... \(catId)")
        badge()
        
         navigationController?.visibleViewController?.navigationItem.title = catName

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       badge()
    request(catId)
        
        
        
    }
   
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_name.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected indexpath \(indexPath.row)")
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("IdCellMenu", forIndexPath: indexPath) as! MenuTableViewCell
       let cell = tableView.dequeueReusableCellWithIdentifier("IdCellMenu") as! MenuTableViewCell
        
        cell.itemName.text = arr_name[indexPath.row]
        cell.itemprice.text = arr_rate[indexPath.row]
        //cell.imageView?.image = iimage[indexPath.row]

       
        cell.itemAddCart.tag = indexPath.row
        cell.itemAddCart.addTarget(self, action: "cartDetected:", forControlEvents: .TouchUpInside)
        
        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
            // print(error)
        }
        
        let url = NSURL(string: self.arr_image[indexPath.row])
        print(url)
        
        cell.itemImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "navheader"), completed: block)
        
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale

        
        return cell
    }
    
    
    func  cartDetected(sender: UIButton)  {
        print("cart tapped \(cartValue)")
        print(sender.tag)
        
        //ProductObject().name_set(arr_name[sender.tag])
        
        seedCart(arr_name[sender.tag], rate: arr_rate[sender.tag], catid: arr_catid[sender.tag], pid: arr_proid[sender.tag], image: arr_image[sender.tag], desc: arr_desc[sender.tag])
        fetchCart()
        fetchAll()
        
        cf.CartValuePluse()
        badge()
    }
    
    func seedCart(name:String, rate:String, catid:String, pid:String, image:String, desc:String) {
        
        // create an instance of our managedObjectContext
        let moc = DataController().managedObjectContext
        
        // we set up our entity by selecting the entity and context that we're targeting
        let entity = NSEntityDescription.insertNewObjectForEntityForName("CartEntity", inManagedObjectContext: moc) as! CartEntity
        
        // add our data
        
        
        entity.setValue(name, forKey: Key().cE_pro_name)
        entity.setValue(rate, forKey: Key().cE_pro_rate)
        entity.setValue(catid, forKey: Key().cE_pro_catid)
        entity.setValue(pid, forKey: Key().cE_pro_id)
        entity.setValue(image, forKey: Key().cE_pro_image)
        entity.setValue(desc, forKey: Key().cE_pro_desc)
        
        // we save our entity
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    func fetchCart() {
        let moc = DataController().managedObjectContext
        let personFetch = NSFetchRequest(entityName: "CartEntity")
        
        do {
            
            
            let fetchedCart = try moc.executeFetchRequest(personFetch) as! [CartEntity]
            print("fetched name = \(fetchedCart.last?.pro_name)")
            
        } catch {
            fatalError("Failed to fetch person: \(error)")
        }
    }
    
    func fetchAll(){
        // Create Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "CartEntity")
        
        // Add Sort Descriptor
        let sortDescriptor = NSSortDescriptor(key: Key().cE_pro_id, ascending: true)
        //fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Execute Fetch Request
        do {
            let result = try DataController().managedObjectContext.executeFetchRequest(fetchRequest)
            
            for managedObject in result {
                if let first = managedObject.valueForKey(Key().cE_pro_id), last = managedObject.valueForKey(Key().cE_pro_name) {
                    print("\(first[1]) \(last)")
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    
    }
    
    func request(var id:String?) {
        print("Mainmenu base url "+Urls().Base_Url)
        Alamofire.request(.POST, Urls().Base_Url+Urls().PHP_FILE_TAB_PRODUCT, parameters: ["category": id!])
            .responseJSON { response in
                //print(response.request)  // original URL request
                print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                let records = response.result.value!.objectForKey("product") as! NSArray
                self.dataRows = records
                
                print("datarows count = \(self.dataRows.count)")
                
                for var i = 0; self.dataRows.count > i; i += 1 {
                    
                    let obj : AnyObject! =  self.dataRows.objectAtIndex(i)
                    
                   
                    
                    let pro_name = obj.objectForKey("name") as! String
                    let pro_id = obj.objectForKey("proid") as! String
                    let pro_catid = obj.objectForKey("caid") as! String
                    let pro_rate = obj.objectForKey("rate") as! String
                    let pro_desc = obj.objectForKey("desc") as! String
                    let pro_image = obj.objectForKey("image") as! String
                    //let status = obj.objectForKey("status") as! String
                    //let success = obj.objectForKey("success") as! String
                    //let url = obj.objectForKey("url") as! String
                    
                    
                    self.arr_name.append(pro_name)
                    self.arr_proid.append(pro_id)
                    self.arr_catid.append(pro_catid)
                    self.arr_rate.append(pro_rate)
                    self.arr_desc.append(pro_desc)
                    self.arr_image.append(pro_image)
                    //self.arr_status.append(status)
                    //self.arr_success.append(success)
                    //self.arr_url.append(url)
                    
                    
                    
                }
               
                print(self.arr_rate)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    //self.name = self.arr_name
                    //self.rate = self.arr_rate
                    // self.image = self.arr_image
                    self.tabView.reloadData()
                    return
                })
        }
        
        

    }
    
    
    
    func badge(){
    
        var cartValue = cf.cartDefaults.integerForKey(Key().cartValue)
        
        print("button tapped \(cartValue)")
        
        
        
        //Custom Badge View
        let badgeButton : MIBadgeButton = MIBadgeButton(frame: CGRectMake(20, 20, 36, 36))
        
        badgeButton.setTitle("Cart", forState: UIControlState.Normal)
        badgeButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        badgeButton.addTarget(self, action: "barButtonAction",forControlEvents: UIControlEvents.TouchUpInside)
        badgeButton.badgeString = String(cartValue);
        badgeButton.badgeBackgroundColor = UIColor.whiteColor()
        badgeButton.badgeTextColor = UIColor.blackColor()
        let barButton : UIBarButtonItem = UIBarButtonItem(customView: badgeButton)
        
        navigationController?.navigationItem.rightBarButtonItem = barButton
        //navigationController?.visibleViewController?.navigationItem.rightBarButtonItem = barButton
        
        //barButton.action = Selector("barButtonAction")
    }
    
    func barButtonAction(sender: UIBarButtonItem) {
    
        print("barbuttonAction tapped")
    }

}
