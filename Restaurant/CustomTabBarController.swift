//
//  CustomTabBarViewController.swift
//  CustomTabBar
//
//  Created by Adam Bardon on 07/03/16.
//  Copyright © 2016 Swift Joureny. All rights reserved.
//

import UIKit
import Alamofire
import ZRScrollableTabBar


class CustomTabBarController: UITabBarController {
    
    var controllerArray = [UIViewController]()
    
    // MARK: - UICollectionViewDataSource protocol
    var dataRows = NSArray()
    
    var arr_categoryid:[String] = []
    var arr_message:[String] = []
    var arr_poid:[String] = []
    var arr_prodname:[String] = []
    var arr_qty:[String] = []
    var arr_rate:[String] = []
    var arr_status:[String] = []
    var arr_success:[String] = []
    var arr_url:[String] = []
    
    var swiftImages:[UIImage] = []
    
    var tabBarr:ZRScrollableTabBar?
    
    var item:[UITabBarItem]?
    
    
    var storyBoard:UIStoryboard?
    
    @IBAction func cartAction(sender: AnyObject) {
        
        print("cart icon tapped")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("SIDcart") as! CartViewController
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorNormal : UIColor = UIColor.blackColor()
        let colorSelected : UIColor = UIColor.whiteColor()
        let titleFontAll : UIFont = UIFont(name: "American Typewriter", size: 10.0)!
        
        let attributesNormal = [
            NSForegroundColorAttributeName : colorNormal,
            NSFontAttributeName : titleFontAll
        ]
        
        let attributesSelected = [
            NSForegroundColorAttributeName : colorSelected,
            NSFontAttributeName : titleFontAll
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, forState: .Selected)
        
         storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        catergRequest()
      
              
    
          }
   
    func catergRequest(){
        print("Mainmenu base url "+Urls().Base_Url)
        Alamofire.request(.POST, Urls().Base_Url+Urls().PHP_FILE_Bulk_Image, parameters: ["storeid": "S0001"])
            .responseJSON { response in
                //print(response.request)  // original URL request
                ////print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                let records = response.result.value!.objectForKey("product") as! NSArray
                self.dataRows = records
                
               
                
                
                for var i = 0; self.dataRows.count > i; i += 1 {
                    
                    let obj : AnyObject! =  self.dataRows.objectAtIndex(i)
                    
                    let categoryid = obj.objectForKey("categoryid") as! String
                    //let message = obj.objectForKey("message") as! String
                    //let poid = obj.objectForKey("poid") as! String
                    let prodname = obj.objectForKey("prodname") as! String
                    //let qty = obj.objectForKey("qty") as! String
                    //let rate = obj.objectForKey("rate") as! String
                    //let status = obj.objectForKey("status") as! String
                    //let success = obj.objectForKey("success") as! String
                    let url = obj.objectForKey("url") as! String
                    
                    
                    self.arr_categoryid.append(categoryid)
                    //self.arr_message.append(message)
                    //self.arr_poid.append(poid)
                    self.arr_prodname.append(prodname)
                    //self.arr_qty.append(qty)
                    //self.arr_rate.append(rate)
                    //self.arr_status.append(status)
                    //self.arr_success.append(success)
                    self.arr_url.append(url)
                    
                    

                    //var itesss = UITabBarItem()
                    //itesss.title = self.arr_prodname[i]
                   var items = UITabBarItem(title:  self.arr_prodname[i], image: nil, tag: i)
                    
                    self.item?.append(items)
                    
                    
                    
                    let controller1 = self.storyBoard!.instantiateViewControllerWithIdentifier("SIDmenu") as! MenuViewController
                    //controller1.tabBarController?.tabBar(tabBarr
                      //  , didSelectItem: nil)
                    controller1.tabBarItem = items
                    
                    controller1.catId = self.arr_categoryid[i]
                    controller1.catName = self.arr_prodname[i]
                    //controller1.navigationController?.visibleViewController?.navigationItem.title = self.arr_prodname[i]
                   // controller1.tabBarItem.title = self.arr_prodname[i]
                    //controller1.tabBarItem.image = self.arr_url[i]
                    
                    
                   
                    
                    // setup "inner" view controller
                    //viewController.foo = bar
                    self.controllerArray.append(controller1)
                    
                    

                    
                    
                   
                    
                    
                    //tabBarr.setItems(<#T##items: [AnyObject]!##[AnyObject]!#>, animated: <#T##Bool#>)
                    //

                    
                   
                    
                    
                }
                
                self.tabBarr = ZRScrollableTabBar(items: self.item)
                self.tabBarr!.scrollableTabBarDelegate = self
                //self.view!.addSubview(self.tabBarr!)
                self.setViewControllers(self.controllerArray, animated: false)
                //self.view!.addSubview(self.tabBarr!)

               
                //if let JSON = response.result.value {
                //    print("JSON: \(JSON)")
                //}
                print(self.arr_prodname)
                //
                //self.collectionview.reloadData()
                //print(records)
                
              
                
                
        }
    }

}
