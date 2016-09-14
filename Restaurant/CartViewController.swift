//
//  CartViewController.swift
//  Restaurant
//
//  Created by Nizamuddeen on 9/14/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//
import UIKit


class CartViewController: UIViewController, UITableViewDataSource,  UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyView: UIView!
    @IBOutlet var clearButton: UIBarButtonItem!
    @IBOutlet var totalCostsLabel: UILabel!
    
   
    
    /// NumberFormatter to get the price of a product formatted right
    lazy var productPriceFormatter: NSNumberFormatter = {
        let productPriceFormatter = NSNumberFormatter()
        productPriceFormatter.numberStyle = .CurrencyStyle
        productPriceFormatter.locale = NSLocale.currentLocale()
        return productPriceFormatter
    }()
    
   
    @IBAction func clearAllButtonPressed(sender: AnyObject) {
        let alertView = UIAlertController(title: "Clear all?", message: "Do you really want to clear all items from your cart?", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "No", style: .Default, handler: nil))
        alertView.addAction(UIAlertAction(title: "Clear", style: .Destructive, handler: { (alertAction) -> Void in
            self.clearCart()
        }))
        presentViewController(alertView, animated: true, completion: nil)
    }
      func clearCart() {
        CartManager.sharedInstance.clearCart()
        tableView.reloadData()
        
        setEmptyViewVisible(true)
    }
    
   
    func updateTotalCostsLabel() {
        totalCostsLabel.text = productPriceFormatter.stringFromNumber(CartManager.sharedInstance.totalPriceInCart())
    }
    
   
    func setEmptyViewVisible(visible: Bool) {
        emptyView.hidden = !visible
        if visible {
            clearButton.enabled = false
            self.view.bringSubviewToFront(emptyView)
        } else {
            clearButton.enabled = true
            self.view.sendSubviewToBack(emptyView)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected indexpath \(indexPath.row)")
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCellWithIdentifier("cartcell") as! CartProductViewCell
        
        //let product = CartManager.sharedInstance.productAtIndexPath(indexPath)
        let product = ProductObject()
        productCell.itemNameLabel.text = product.name_get(indexPath.row)
        //productCell.itemPriceLabel.text = productPriceFormatter.stringFromNumber(product.productPrice())
        
        //if let imageURL = product.imageURL() {
        //    productCell.productImageView.hnk_setImageFromURL(imageURL)
        //}
        
        return productCell
    }
    
       func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Cart"
        
        //tableView.estimatedRowHeight = 100
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    /**
     <#Description#>
     
     - parameter animated: <#animated description#>
     */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //checkEmptyStateOfCart()
        //tableView.reloadData()
        
       // updateTotalCostsLabel()
    }
    
    /**
     <#Description#>
     */
    func checkEmptyStateOfCart() {
        setEmptyViewVisible(CartManager.sharedInstance.numberOfItemsInCart() == 0)
    }
    
    /**
     <#Description#>
     
     - returns: <#return value description#>
     */
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
