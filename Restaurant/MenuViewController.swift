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

class MenuViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
   // @IBOutlet var navitem: UIBarButtonItem!
    
    //var cartValue:String = "0"
    var cartValue :Int = 0
    
    var catId:String?
    
   // var tab_title:String?
    
    // MARK: - UICollectionViewDataSource protocol
    var dataRows = NSArray()
    
    var arr_name:[String] = []
    var arr_proid:[String] = []
    var arr_catid:[String] = []
    var arr_rate:[String] = []
    var arr_desc:[String] = []
    var arr_image:[String] = []
    
    var swiftImages:[UIImage] = []

    
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
    
    let image=[UIImage(named:"nizam"),UIImage(named:"jamal"),UIImage(named:"mansoor"),UIImage(named:"nizam"),UIImage(named:"jamal"),UIImage(named:"mansoor"),UIImage(named:"nizam"),UIImage(named:"jamal"),UIImage(named:"mansoor"),UIImage(named:"nizam"),UIImage(named:"jamal"),UIImage(named:"mansoor")]*/
    
    
   
    @IBOutlet var navItm: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
   let badgeButton : MIBadgeButton = MIBadgeButton(frame: CGRectMake(20, 20, 36, 36))
    
    
    override func viewWillAppear(animated: Bool) {
        
        //self.tabBarItem.title = "gfdsg"
        print("cayId............... \(catId)")
        badge(String(cartValue))
        request(catId)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        
    }
   
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_proid.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected indexpath \(indexPath.row)")
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("IdCellMenu", forIndexPath: indexPath) as! MenuTableViewCell
       //let cell = tableView.dequeueReusableCellWithIdentifier("IdCellMenu") as! MenuTableViewCell
        
        cell.itemName.text = arr_name[indexPath.row]
        cell.itemPrice.text = arr_rate[indexPath.row]

       /*
        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
            // print(error)
        }
       
        
        
        cell.itemAddCart.tag = indexPath.row
        cell.itemAddCart.addTarget(self, action: "cartDetected:", forControlEvents: .TouchUpInside)
        
        
        let url = NSURL(string: self.arr_image[indexPath.row])
        print(url)
        
        cell.itemImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "navheader"), completed: block)
        
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale */

        
        return cell
    }
    
    
    func  cartDetected(sender: UIButton)  {
        print("cart tapped \(cartValue)")
        print(sender.tag)
        
       
        
        
        
        badge(String(cartValue++))
      
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
                //if let JSON = response.result.value {
                //    print("JSON: \(JSON)")
                //}
                print(self.arr_image)
                //
                //self.tableView.reloadData()
                //print(records)
        }

    }
    
    func badge(value:String!){
    
        //Custom Badge View
        badgeButton.setTitle("Cart", forState: UIControlState.Normal)
        badgeButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        badgeButton.badgeBackgroundColor = UIColor.whiteColor()
        badgeButton.badgeTextColor = UIColor.blackColor()
        badgeButton.badgeString = value
        //badgeButton.accessibilityIncrement()
        
        let barButton : UIBarButtonItem = UIBarButtonItem(customView: badgeButton)
        self.navigationItem.rightBarButtonItem = barButton
    }

}
