//
//  CommonFuntion.swift
//  Restaurant
//
//  Created by Suriya on 7/25/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit

class CommonFunction {
    
    
   let LoginDetails = NSUserDefaults.standardUserDefaults()
    
    let cartDefaults = NSUserDefaults.standardUserDefaults()
    
    var cartValue:Int = 0
    
    func CartValuePluse(){
    
        
        cartDefaults.setInteger(cartValue++, forKey: Key().cartValue)
    }
    
    func jsonparsing() {
    //Making Connection
    let urlAsString = "http://jsonplaceholder.typicode.com/posts/1"
    
    
    //let urlAsString = "http://date.jsontest.com"
    let url = NSURL(string: urlAsString)!
    let urlSession = NSURLSession.sharedSession()
    
    
    let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
        if (error != nil) {
            print(error!.localizedDescription)
        }
        
        do {
            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                print(jsonResult)
                
                let jsonDate: String! = jsonResult["title"] as! String
                let jsonTime: String! = jsonResult["body"] as! String
                
                dispatch_async(dispatch_get_main_queue(), {
                  //  self.dateTV.text = jsonDate
                    //self.timeTV.text = jsonTime
                    print("tilte \(jsonDate)")
                    print("body \(jsonTime)")
                })
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
    })
    
    jsonQuery.resume()
    }

}
