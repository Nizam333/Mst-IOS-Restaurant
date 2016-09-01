import UIKit
import Foundation

class MainViewController: UIViewController {
    
    //@IBOutlet var textVw: UILabel!
    
   var cf = CommonFunction()
    
    var status:Bool = false
    
    @IBOutlet var containerView: UIView!

     weak var currentViewController: UIViewController?
    
     //var idd=1
    
   let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    
    
    
    override func viewDidDisappear(animated: Bool) {
         print("viewDidDisappear called")
    }
    override func viewDidAppear(animated: Bool) {
         print("viewDidAppear called")
    }
    
    override func viewDidLoad() {
        
        status = cf.LoginDetails.boolForKey(Key().login_status)
        
        //Custom Badge View
        let badgeButton : MIBadgeButton = MIBadgeButton(frame: CGRectMake(20, 20, 36, 36))
        badgeButton.setTitle("Cart", forState: UIControlState.Normal)
        badgeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        badgeButton.badgeString = "1";
        badgeButton.badgeBackgroundColor = UIColor.whiteColor()
        badgeButton.badgeTextColor = UIColor.blackColor()
        let barButton : UIBarButtonItem = UIBarButtonItem(customView: badgeButton)
        self.navigationItem.rightBarButtonItem = barButton
        
        
        //container view first view
        
        self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDmyorder")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(self.currentViewController!.view, toView: self.containerView)
        
        let ViewId: Int? = prefs.integerForKey("data")
        print("data is \(ViewId)")
        
        
        changeContainer(ViewId!)
      
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
    
   
    
    
    func changeContainer(id:Int){
       
        if id == 0{
        
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDlogin")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
            
            self.navigationItem.title="Sign In"
            
        }else if id == 1 {
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDmainmenu")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
                
            self.navigationItem.title="Main Menu"
        } else if id == 2{
            
            if(self.status==true){
                
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDmyorder")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
                
                self.navigationItem.title="My Order"
            
            }else {
            
                Alert_Lgin("SIDlogin")
            }
           
            
        }
            else if id == 3{
            
            if(self.status==true){
                
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDreservation")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
                self.navigationItem.title="Reservations"
                
            }else {
                
                Alert_Lgin("SIDlogin")
            }
            
            
            } else if id == 4{
            
            if(self.status==true){
                
                
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDrewards")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
                self.navigationItem.title="Rewards"
                
            }else {
                
                Alert_Lgin("SIDlogin")
            }
            
        
            
            } else if id == 5{
            
            if(self.status==true){
                
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDgiftcards")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
                
                self.navigationItem.title="Gift Cards"
                
            }else {
                
                Alert_Lgin("SIDlogin")
            }
            
            
            } else if id == 6{
            
            if(self.status==true){
                
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDmyprofile")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
                
                self.navigationItem.title="My Profile"
                
            }else {
                
                Alert_Lgin("SIDlogin")
            }
            
            
            } else if id == 7{
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDcallus")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
            
             self.navigationItem.title="Call Us"
            
            } else if id == 8{
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDterms")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
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
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier(sbId)
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
            
            self.navigationItem.title="Sign In"
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        

    }
    
}
