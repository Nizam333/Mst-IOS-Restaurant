import UIKit
import Foundation

class MainViewController: UIViewController {
    
    //@IBOutlet var textVw: UILabel!
    
   
    
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
        
        print("viewdidload called")
        
       
        
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
            let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDmyorder")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
            
            self.navigationItem.title="My Order"
            
        }
            else if id == 3{
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDreservation")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
             self.navigationItem.title="Reservations"
            
            } else if id == 4{
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDrewards")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
             self.navigationItem.title="Rewards"
            
        
            
            } else if id == 5{
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDgiftcards")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
            
             self.navigationItem.title="Gift Cards"
            
            } else if id == 6{
                let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SIDmyprofile")
                newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
                self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
                self.currentViewController = newViewController
            
             self.navigationItem.title="My Profile"
            
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
    
    
    
}
