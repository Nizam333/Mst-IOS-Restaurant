//
//  SignupViewController.swift
//  Restaurant
//
//  Created by Suriya on 7/20/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController {
    
    
    var dataRows = NSArray()
    
    @IBOutlet var tf_name: UITextField!
    @IBOutlet var tf_email: UITextField!
    @IBOutlet var tf_password: UITextField!
    @IBOutlet var tf_mobile: UITextField!
    @IBOutlet var tf_countrycode: UITextField!
    
    @IBOutlet var progressView: ProgressView!
    
    
    @IBAction func signup(sender: AnyObject) {
        
        var name = self.tf_name.text
        var email = self.tf_email.text
        var countryCode = self.tf_countrycode.text
        var mobileNumber = self.tf_mobile.text
        var password = self.tf_password.text
        
        // Validate the text fields
        
        if name?.characters.count < 5{
            var alert = UIAlertView(title: "Invalid", message: "Please enter valid Name", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }else if email?.characters.count < 10{
            var alert = UIAlertView(title: "Invalid", message: "Please enter valid email address", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }else if countryCode?.characters.count < 2{
            var alert = UIAlertView(title: "Invalid", message: "Please enter valid country code", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }else if mobileNumber?.characters.count < 10 {
            var alert = UIAlertView(title: "Invalid", message: "Mobile Number must be greater than 10 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if password?.characters.count < 6 {
            var alert = UIAlertView(title: "Invalid", message: "Password must be greater than 6 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            
            
            var Mobile = countryCode!+mobileNumber!
            
            
            Request(name!,email:email!,mobilenumber:Mobile,pass: password!)
            
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
    func Request(var name:String ,var email:String,var mobilenumber:String ,var pass:String){
        
        self.progressView.animateProgressView()
        
        print("signup name= \(name) email= \(email) mobile= \(mobilenumber) password= \(pass)")
        
        print("Mainmenu base url "+Urls().Base_Url)
        
       
        Alamofire.request(.POST, Urls().Base_Url+Urls().PHP_FILE_SignUp, parameters: ["name": name,"mobilenum":mobilenumber,"email": email,"password":pass])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                let success = response.result.value!.objectForKey("success") as! Int
                
                print("success= \(success)")
                
                if (success==1) {
                    
                    print("Signup success")
                    
                    let records = response.result.value!.objectForKey("product") as! NSArray
                    print(records)
                    self.dataRows = records
                    
                    // "success":1,"product":[{"userid":"3976","name":"Nizam","mobilenum":"919994471706","email":"nizam@nsamsoft.com","password":"333333","success":1,"status":"true","message":"Login success."
                    
                    
                    for var i = 0; self.dataRows.count > i; i += 1 {
                        
                        let obj : AnyObject! =  self.dataRows.objectAtIndex(i)
                        
                        
                        
                       // let message = obj.objectForKey("message") as! String
                       // let status = obj.objectForKey("status") as! String
                        //let success = obj.objectForKey("success") as! String
                        let userid = obj.objectForKey("userid") as! String
                        //let userid = obj.objectForKey("userid") as! String
                        //let success = obj.objectForKey("success") as! Int
                        //let status = obj.objectForKey("status") as! String
                        //let success = obj.objectForKey("success") as! String
                        // let url = obj.objectForKey("url") as! String
                        
                        
                        print("userid=  \(userid)")
                        
                        
                        
                        
                    }
                    
                    var alert = UIAlertView(title: "Signup Success", message: "You successfully Signed in ", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    
                }else {
                    
                    var alert = UIAlertView(title: "Signup Iailure", message: "please check your datas or try again later", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
                
                self.progressView.hideProgressView()
                
                
                
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
