import UIKit
import Foundation
import Alamofire

class MainViewController: UIViewController {
    
    //@IBOutlet var textVw: UILabel!
    
   var cf = CommonFunction()
    
    var status:Bool = false
    
     var dataRows = NSArray()
    
    @IBOutlet var containerView: UIView!

     weak var currentViewController: UIViewController?
    
     //var idd=1
    
   let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    
    
    
    override func viewDidDisappear(animated: Bool) {
         print("viewDidDisappear called")
    }
    override func viewDidAppear(animated: Bool) {
         print("viewDidAppear called")
        
        batch()
    }
    
    override func viewDidLoad() {
        
        status = cf.LoginDetails.boolForKey(Key().login_status)
        
        
        
        //container view first view
        
        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDmyorder")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(self.currentViewController!.view, toView: self.containerView)
        
        let ViewId: Int? = prefs.integerForKey("data")
        print("data is \(ViewId)")
        
        
        changeContainer(ViewId!,con: currentViewController!)
      
        super.viewDidLoad()
        
        
        
        
        print("main viewdidload called \(ViewId)")
        
       
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.whiteColor()
        
        
       
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: ">>>",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: #selector(didTapOpenButton)
        )
    }
    
    func didTapOpenButton(sender: UIBarButtonItem) {
        if let drawerController = navigationController?.parentViewController as? KYDrawerController {
            drawerController.setDrawerState(.Opened, animated: true)
        }
    }
    
    
    //container view
    func batch() {
        var cartValue = cf.cartDefaults.integerForKey(Key().cartValue)
        
        
        //Custom Badge View
        let badgeButton : MIBadgeButton = MIBadgeButton(frame: CGRectMake(20, 20, 36, 36))
        badgeButton.setTitle("Cart", forState: UIControlState.Normal)
        badgeButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        badgeButton.badgeString = String(cartValue);
        badgeButton.badgeBackgroundColor = UIColor.whiteColor()
        badgeButton.badgeTextColor = UIColor.blackColor()
        let barButton : UIBarButtonItem = UIBarButtonItem(customView: badgeButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
   
    
    
    func changeContainer(id:Int,con:UIViewController){
       
        if id == 0{
        
            
            if(self.status==true){
            
                let newViewController = con.storyboard?.instantiateViewControllerWithIdentifier("SIDmyprofile")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(con, toViewController: newViewController!)
                self.currentViewController = newViewController
                
                self.navigationItem.title="My Profile"
                
            }else {
                
                let newViewController = con.storyboard?.instantiateViewControllerWithIdentifier("SIDlogin")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(con, toViewController: newViewController!)
                self.currentViewController = newViewController
                
                self.navigationItem.title="Sign In"
            }
            
        }else if id == 1 {
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDmainmenu")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(con, toViewController: newViewController!)
            self.currentViewController = newViewController
                
            self.navigationItem.title="Main Menu"
        } else if id == 2{
            
            if(self.status==true){
                
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDmyorder")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(con, toViewController: newViewController!)
                self.currentViewController = newViewController
                
                self.navigationItem.title="My Order"
            
            }else {
            
                Alert_Lgin("SIDmyorder")
            }
           
            
        }
            else if id == 3{
            
            if(self.status==true){
                
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDreservation")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(con, toViewController: newViewController!)
                self.currentViewController = newViewController
                self.navigationItem.title="Reservations"
                
            }else {
                
                Alert_Lgin("SIDreservation")
            }
            
            
            } else if id == 4{
            
            if(self.status==true){
                
                
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDrewards")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(con, toViewController: newViewController!)
                self.currentViewController = newViewController
                self.navigationItem.title="Rewards"
                
            }else {
                
                Alert_Lgin("SIDrewards")
            }
            
        
            
            } else if id == 5{
            
            if(self.status==true){
                
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDgiftcards")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(con, toViewController: newViewController!)
                self.currentViewController = newViewController
                
                self.navigationItem.title="Gift Cards"
                
            }else {
                
                Alert_Lgin("SIDgiftcards")
            }
            
            
            } else if id == 6{
            
            if(self.status==true){
                
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDmyprofile")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(con, toViewController: newViewController!)
                self.currentViewController = newViewController
                
                self.navigationItem.title="My Profile"
                
            }else {
                
                Alert_Lgin("SIDmyprofile")
            }
            
            
            } else if id == 7{
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDcallus")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(con, toViewController: newViewController!)
                self.currentViewController = newViewController
            
             self.navigationItem.title="Call Us"
            
            } else if id == 8{
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDterms")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(con, toViewController: newViewController!)
                self.currentViewController = newViewController
            
             self.navigationItem.title="Terms and Conditions"
        }
        
    }
    
    
    
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMoveToParentViewController(nil)
        self.addChildViewController(newViewController)
        self.addSubview(newViewController.view, toView:self.containerView!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
            },
                                   completion: { finished in
                                    oldViewController.view.removeFromSuperview()
                                    oldViewController.removeFromParentViewController()
                                    newViewController.didMoveToParentViewController(self)
        })
    }
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
            options: [], metrics: nil, views: viewBindingsDict))
    }
    
    func Alert_Lgin(var sbId:String)  {
        
        
        
        
        let alert = UIAlertController(title: "Alert!!", message: "You are not signed in yet, Do you wnat Signin? ", preferredStyle: UIAlertControllerStyle.Alert)
            //alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            
           /* let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier(sbId)
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
            
            self.navigationItem.title="Sign In" */
            
           self.SignIn(sbId)
        
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDmainmenu")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
            
            self.navigationItem.title="Main Menu"

        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        

    }
    
    func SignIn(var sid:String)  {
        
        let placeholder_username = NSAttributedString(string: "Mobile number with country code", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
        let placeholder_password = NSAttributedString(string: "Some", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
        //1. Create the alert controller.
        var alert = UIAlertController(title: "Signin ", message: "", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            //textField.text = "Some default text."
            
            textField.attributedPlaceholder = placeholder_username
        })
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            //textField.text = "Some default text."
            textField.secureTextEntry = true
            
            textField.attributedPlaceholder = placeholder_password
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Signin", style: .Default, handler: { (action) -> Void in
            let username = alert.textFields![0] as UITextField
            let password = alert.textFields![1] as UITextField
            var un = username.text
            var pw = password.text
            print("Text field username = : \(username.text)")
            print("Text field password = : \(password.text)")
            
            self.Request(un!,pass:pw!,sid:sid)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
            
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDmainmenu")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
            
            self.navigationItem.title="Main Menu"
        }))
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func Request(var userr:String ,var pass:String, var sid:String){
        
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
                    
                    self.Signin_success(sid)
                    
                    
                    
                }else {
                    self.Signin_Fail(sid)
                   
                }
                
                
                
                
                
                
        }
    }
    
    func Signin_success(var sid:String){
        
        //var alert = UIAlertView(title: "Signin Success", message: "You successfully logged in ", delegate: self, cancelButtonTitle: "OK")
        var alert = UIAlertController(title: "Signin Success ", message: "You successfully logged in", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            
             let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier(sid)
             newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
             self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
             self.currentViewController = newViewController
             
             self.navigationItem.title="Sign In"
          
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)

    
    }
    
    func Signin_Fail(var sid:String){
        
       // var alert = UIAlertView(title: "Signin Iailure", message: "please check your credintial", delegate: self, cancelButtonTitle: "OK")
        var alert = UIAlertController(title: "Signin Failure ", message: "please check your credintial", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            
             self.SignIn(sid)
            
          
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)

        
        
        
    
    }

}
