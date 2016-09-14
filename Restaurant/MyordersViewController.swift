//
//  MyordersViewController.swift
//  Restaurant
//
//  Created by Suriya on 7/19/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


class MyordersViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
    
    // var tab_title:String?
    
    // MARK: - UICollectionViewDataSource protocol
    var dataRows = NSArray()
     var cf = CommonFunction()
    
    
    var arr_order_id:[String] = []
    var arr_estideli_time:[String] = []
    var arr_order_date:[String] = []
    var arr_order_time:[String] = []
    var arr_payment_mode:[String] = []
    var arr_delivery_address:[String] = []
    var arr_order_status:[String] = []
    var arr_statuscode:[String] = []

    
    
    
    var swiftImages:[UIImage] = []
    
    
    
    
    @IBOutlet var tabView: UITableView!
    
    
   
    
    
    override func viewWillAppear(animated: Bool) {
        
       
        
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("user id = \(cf.LoginDetails.stringForKey(Key().user_id))")
        
        
        var userid = cf.LoginDetails.stringForKey(Key().user_id)
       
        if(userid != nil){
        
        request(userid)
            
            
        }
        
        
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_order_id.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected indexpath \(indexPath.row)")
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("IdCellMenu", forIndexPath: indexPath) as! MenuTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("IdCellOrder") as! OrdersTableViewCell
        
        cell.tv_orderId.text = arr_order_id[indexPath.row]
        cell.tv_orderDate.text = arr_order_date[indexPath.row]
        cell.tv_orderStatus.text = arr_order_status[indexPath.row]
        
        
        
        
        return cell
    }
    
    
    
    func request( id:String?) {
        print("Mainmenu base url "+Urls().Base_Url)
        Alamofire.request(.POST, Urls().Base_Url+Urls().PHP_FILE_MYORDERS, parameters: ["userid": id!])
            .responseJSON { response in
                //print(response.request)  // original URL request
                print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                let success = response.result.value!.objectForKey("success") as! Int
                
                print("success= \(success)")
                
                if (success==1) {
                    
                    print("login success")
                    
                    let records = response.result.value!.objectForKey("product") as! NSArray
                    print(records)
                    self.dataRows = records
                    
                    
                    
                    
                    for var i = 0; self.dataRows.count > i; i += 1 {
                        
                        let obj : AnyObject! =  self.dataRows.objectAtIndex(i)
                        
                        //str_orderid += json1.getString("order_id")+ "~";
                        //str_estime += json1.getString("estideli_time")+ "~";
                        //str_order_date += json1.getString("order_date")+ "~";
                       // str_order_time += json1.getString("order_time")+ "~";
                        //str_mode += json1.getString("payment_mode")+ "~";
                        //str_deli_address +=json1.getString("delivery_address")+"~";
                        //str_status += json1.getString("order_status")+"~";
                       // str_stcode += json1.getString("statuscode")+"~";
                        
                        let str_orderid = obj.objectForKey("order_id") as! String
                        let str_estime = obj.objectForKey("estideli_time") as! String
                        let str_order_date = obj.objectForKey("order_date") as! String
                        let str_order_time = obj.objectForKey("order_time") as! String
                        let str_mode = obj.objectForKey("payment_mode") as! String
                        let str_deli_address = obj.objectForKey("delivery_address") as! String
                        let str_status = obj.objectForKey("order_status") as! String
                        let str_stcode = obj.objectForKey("statuscode") as! String
                        // let url = obj.objectForKey("url") as! String
                    
                    
                    self.arr_order_id.append(str_orderid)
                    self.arr_estideli_time.append(str_estime)
                    self.arr_order_date.append(str_order_date)
                    self.arr_order_time.append(str_order_time)
                    self.arr_payment_mode.append(str_mode)
                    self.arr_delivery_address.append(str_deli_address)
                    self.arr_order_status.append(str_status)
                    self.arr_statuscode.append(str_stcode)
                   
                    
                    
                    
                }
                
                print(self.arr_order_id)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    //self.name = self.arr_name
                    //self.rate = self.arr_rate
                    // self.image = self.arr_image
                    self.tabView.reloadData()
                    return
                })
                    
                }else{
                
                    var alert = UIAlertView(title: "Empty!!", message: "There is no orders for you", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                
                }
        }
        
        
        
    }
    
  
    
}
