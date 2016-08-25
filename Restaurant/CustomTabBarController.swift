//
//  CustomTabBarViewController.swift
//  CustomTabBar
//
//  Created by Adam Bardon on 07/03/16.
//  Copyright © 2016 Swift Joureny. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    var controllerArray = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start from here
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let controller1 = storyBoard.instantiateViewControllerWithIdentifier("SIDmenu") as! MenuViewController
       let controller2 = storyBoard.instantiateViewControllerWithIdentifier("SIDmenu") as! MenuViewController
       // let controller3 = storyBoard.instantiateViewControllerWithIdentifier("friends") as! ExploreNav
        //let controller4 = storyBoard.instantiateViewControllerWithIdentifier("controller3ID") as! controller3VC
        controllerArray.append(controller1)
      controllerArray.append(controller2)
       // controllerArray.append(controller3)
//controllerArray.append(controller4)
        self.setViewControllers(controllerArray, animated: true)
    
          }
   

}
