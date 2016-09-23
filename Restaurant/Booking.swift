//
//  Booking.swift
//  Restaurant
//
//  Created by Nizamuddeen on 9/23/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit
import Alamofire

class Booking: NSObject {
    
    func getOrderId(userid:String, address:String, mode:String, total:String, latt:String,lngg:String, stoid:String, distance:String) -> String {
        return ""
    }
    
    func makeBooking(userid:String, address:String, mode:String, total:String, latt:String,lngg:String, stoid:String, distance:String, products:NSArray) -> String {
        
       let orderId = getOrderId(userid, address: address, mode: mode, total: total, latt: latt, lngg: lngg, stoid: stoid, distance: distance)
        
        let index = products.count
        var i = 0
        
        for i = 0; i < index; i += 1 {
            
            let urlString = Urls().Base_Url+Urls().PHP_FILE_ORDER_ID
            
            let parameters = products[i]
            //parameters.appendData()
            
            Alamofire.request(.POST, urlString, parameters: parameters as? [String : AnyObject])
                
                .responseJSON { response in
                    print(response.request)  // original URL request
                    print(response.response) // URL response
                    print(response.data)     // server data
                    print(response.result)   // result of response serialization
            }
        }
        
        return""
    }

}
