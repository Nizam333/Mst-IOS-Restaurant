//
//  CustomTabBarViewController.swift
//  CustomTabBar
//
//  Created by Adam Bardon on 07/03/16.
//  Copyright © 2016 Swift Joureny. All rights reserved.
//

import UIKit
import Alamofire

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
    
    var storyBoard:UIStoryboard?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    
                    

                    
                   
                    let controller1 = self.storyBoard!.instantiateViewControllerWithIdentifier("SIDmenu") as! MenuViewController
                    //controller1.tabBarItem.title = self.arr_prodname[i]
                    controller1.catId = self.arr_categoryid[i]
                     controller1.tabBarItem.title = self.arr_prodname[i]
                    // setup "inner" view controller
                    //viewController.foo = bar
                    self.controllerArray.append(controller1)
                    
                    self.setViewControllers(self.controllerArray, animated: false)
                    
                   
                    
                   
                    
                    
                }
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
