//
//  MyProfileViewController.swift
//  Restaurant
//
//  Created by Suriya on 7/20/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit
import Alamofire

class MyProfileViewController: UIViewController {
    
    // MARK: - UICollectionViewDataSource protocol
    var dataRows = NSArray()
    
    @IBOutlet var lbl_name: UILabel!
    @IBOutlet var lbl_mobile: UILabel!
    @IBOutlet var lbl_email: UILabel!
    
    @IBAction func signout(sender: AnyObject) {
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        request("919994471706")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func request(var mob:String?) {
        print("Mainmenu base url "+Urls().Base_Url)
        Alamofire.request(.POST, Urls().Base_Url+Urls().PHP_FILE_VIEWPROFILE, parameters: ["mobnum": mob!])
            .responseJSON { response in
                //print(response.request)  // original URL request
                print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                let success = response.result.value!.objectForKey("success") as! Int
                
                print("success= \(success)")
                
                if (success==1) {
                
                let records = response.result.value!.objectForKey("product") as! NSArray
                self.dataRows = records
                
                print("datarows count = \(self.dataRows.count)")
                
                for var i = 0; self.dataRows.count > i; i += 1 {
                    
                    let obj : AnyObject! =  self.dataRows.objectAtIndex(i)
                    
                    //{"product":[{"proname":"Nizam","mobnum":"919994471706","emailid":"nizam@nsamsoft.com","success":1,"status":"true","message":"Getting record success."}],"success":1}
                    
                    let proname = obj.objectForKey("proname") as! String
                    let mobnum = obj.objectForKey("mobnum") as! String
                    let emailid = obj.objectForKey("emailid") as! String
                   // let success = obj.objectForKey("success") as! String
                   // let status = obj.objectForKey("status") as! String
                   // let message = obj.objectForKey("message") as! String
                    
                    self.lbl_name.text=proname
                    self.lbl_mobile.text=mobnum
                    self.lbl_email.text=emailid
                    
                }
                    
                    
                    
                
               
                }else{
                
                
                }
        
        }
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
