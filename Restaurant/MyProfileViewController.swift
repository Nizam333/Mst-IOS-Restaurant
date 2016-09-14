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
    
    var cf = CommonFunction()
    
    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var conview: UIView!
    
    weak var currentViewController: UIViewController?
    
    @IBOutlet var lbl_name: UILabel!
    @IBOutlet var lbl_mobile: UILabel!
    @IBOutlet var lbl_email: UILabel!
    
    @IBOutlet var btn_signout: UIButton!
    
    @IBAction func signout(sender: AnyObject) {
        
       Alert_LogOut()
        
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
    func Alert_LogOut()  {
        
        
        let alert = UIAlertController(title: "Alert!!", message: "Are you sure you want to signout? ", preferredStyle: UIAlertControllerStyle.Alert)
        //alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            
            self.cf.LoginDetails.setObject(nil, forKey: Key().user_name)
            self.cf.LoginDetails.setObject(nil, forKey: Key().user_mobile)
            self.cf.LoginDetails.setObject(nil, forKey: Key().user_email)
            self.cf.LoginDetails.setObject(nil, forKey: Key().user_id)
            
            self.cf.LoginDetails.setBool(false, forKey: Key().login_status)
            
            
            var alertt = UIAlertController(title: "Success", message: "You have successfully Signed out ", preferredStyle: UIAlertControllerStyle.Alert)
            //alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            alertt.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
                
                
                self.lbl_name.text = "Name"
                self.lbl_email.text = "Email"
                self.lbl_mobile.text = "Mobile Number"
                self.btn_signout.titleLabel?.text = "Signin"
                
                let ViewId: Int? = self.prefs.integerForKey("data")
                print("data is \(ViewId)")

               // MainViewController().changeContainer(ViewId!,con: MainViewController().currentViewController!)
                
               // let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
              //  let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("MainNavigation") as! DrawerViewController
              //  self.presentViewController(nextViewController, animated:true, completion:nil)
                
            }))
            self.presentViewController(alertt, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
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
