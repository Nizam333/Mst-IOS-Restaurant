//
//  MenuViewController.swift
//  Restaurant
//
//  Created by Suriya on 7/22/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit
import Alamofire

class MenuViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
   // @IBOutlet var navitem: UIBarButtonItem!
    
    //var cartValue:String = "0"
    var cartValue :Int = 0
    
    let itemTitle=[
        "Chicken",
        "Mutton",
        "Veg","Beverage",
        "Chowder",
        "Grill","Roast",
        "Jamal",
        "Macroni","Almtluth",
        "Meat",
        "sweets"
    ]
    
    let itemprice=["30","40","50","20","10","23","34","56","76","65","43","21"]
    
    let image=[UIImage(named:"nizam"),UIImage(named:"jamal"),UIImage(named:"mansoor"),UIImage(named:"nizam"),UIImage(named:"jamal"),UIImage(named:"mansoor"),UIImage(named:"nizam"),UIImage(named:"jamal"),UIImage(named:"mansoor"),UIImage(named:"nizam"),UIImage(named:"jamal"),UIImage(named:"mansoor")]
    
    
   
    @IBOutlet var navItm: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
   let badgeButton : MIBadgeButton = MIBadgeButton(frame: CGRectMake(20, 20, 36, 36))
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.navitem.title = "hello"
        
        
        badge(String(cartValue))
        
        
    }
   
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemTitle.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
       let cell = tableView.dequeueReusableCellWithIdentifier("IdCellMenu") as! MenuTableViewCell
        
        cell.itemName.text = itemTitle[indexPath.row]
        //cell.itemPrice.text = itemprice[indexPath.row]
        cell.itemImage.image = image[indexPath.row]
        
        cell.itemAddCart.tag = indexPath.row
        cell.itemAddCart.addTarget(self, action: "cartDetected:", forControlEvents: .TouchUpInside)
        //cell.itemCart.addTarget(self, action: #selector(ClassName.FunctionName(_:), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    
    func  cartDetected(sender: UIButton)  {
        print("cart tapped \(cartValue)")
        print(sender.tag)
        
       
        
        
        
        badge(String(cartValue++))
      
    }
    
    func badge(value:String!){
    
        //Custom Badge View
        badgeButton.setTitle("Cart", forState: UIControlState.Normal)
        badgeButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        badgeButton.badgeBackgroundColor = UIColor.whiteColor()
        badgeButton.badgeTextColor = UIColor.blackColor()
        badgeButton.badgeString = value
        //badgeButton.accessibilityIncrement()
        
        let barButton : UIBarButtonItem = UIBarButtonItem(customView: badgeButton)
        self.navigationItem.rightBarButtonItem = barButton
    }

}
