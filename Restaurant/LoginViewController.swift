//
//  LoginViewController.swift
//  Restaurant
//
//  Created by Suriya on 7/20/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    var cf = CommonFunction()
    
    
    
    var dataRows = NSArray()
    
    @IBOutlet var tf_countryCode: UITextField!
    @IBOutlet var tf_mobileNumber: UITextField!
    @IBOutlet var tf_password: UITextField!
    @IBOutlet var btn_signIn: UIButton!
    
    
    @IBAction func SignIn(sender: AnyObject) {
        
        var countryCode = self.tf_countryCode.text
        var mobileNumber = self.tf_mobileNumber.text
        var password = self.tf_password.text
        
        // Validate the text fields
       
        if countryCode?.characters.count < 2{
                var alert = UIAlertView(title: "Invalid", message: "Please enter valid country code", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
        }else if mobileNumber?.characters.count < 10 {
            var alert = UIAlertView(title: "Invalid", message: "Mobile Number must be greater than 10 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if password?.characters.count < 6 {
            var alert = UIAlertView(title: "Invalid", message: "Password must be greater than 6 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
           
            
            var username = countryCode!+mobileNumber!
            
            
            Request(username,pass: password!)
            
            // Send a request to login
            }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func Request(var userr:String ,var pass:String){
        
        print("mobile= \(userr) password= \(pass)")
        
        print("Mainmenu base url "+Urls().Base_Url)
        Alamofire.request(.POST, Urls().Base_Url+Urls().PHP_FILE_Login, parameters: ["mobilenum": userr,"password":pass])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                let success = response.result.value!.objectForKey("success") as! Int
                
                print("success= \(success)")
                
                if (success==1) {
                    
                    print("login success")
                    
                    let records = response.result.value!.objectForKey("product") as! NSArray
                    print(records)
                    self.dataRows = records
                    
                   // "success":1,"product":[{"userid":"3976","name":"Nizam","mobilenum":"919994471706","email":"nizam@nsamsoft.com","password":"333333","success":1,"status":"true","message":"Login success."
                    
                    
                    for var i = 0; self.dataRows.count > i; i += 1 {
                        
                        let obj : AnyObject! =  self.dataRows.objectAtIndex(i)
                        
                        
                        
                        let name = obj.objectForKey("name") as! String
                        let mobilenum = obj.objectForKey("mobilenum") as! String
                        let email = obj.objectForKey("email") as! String
                        let password = obj.objectForKey("password") as! String
                        let userid = obj.objectForKey("userid") as! String
                        //let success = obj.objectForKey("success") as! Int
                        //let status = obj.objectForKey("status") as! String
                        //let success = obj.objectForKey("success") as! String
                        // let url = obj.objectForKey("url") as! String
                        
                        
                        print(name+" "+email)
                        
                        self.cf.LoginDetails.setObject(name, forKey: Key().user_name)
                        self.cf.LoginDetails.setObject(mobilenum, forKey: Key().user_mobile)
                        self.cf.LoginDetails.setObject(email, forKey: Key().user_email)
                        self.cf.LoginDetails.setObject(userid, forKey: Key().user_id)
                        
                        self.cf.LoginDetails.setBool(true, forKey: Key().login_status)
                        
                        
                    }
                    
                    var alert = UIAlertView(title: "Signin Success", message: "You successfully logged in ", delegate: self, cancelButtonTitle: "OK")
                    alert.show()

                
                }else {
                
                    var alert = UIAlertView(title: "Signin Iailure", message: "please check your credintial", delegate: self, cancelButtonTitle: "OK")
                alert.show()
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
