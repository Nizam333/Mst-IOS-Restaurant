//
//  CartProductViewCell.swift
//  Restaurant
//
//  Created by Nizamuddeen on 9/14/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit


typealias ButtonHandler = (CartProductViewCell) -> Void

class CartProductViewCell: UITableViewCell {

    @IBOutlet var itemImage: UIImageView!

    @IBOutlet var itemPrice: UILabel!
    @IBOutlet var itemName: UILabel!
   
    
    @IBOutlet var itemQty: UILabel!
    
    @IBOutlet var img_plus: UIButton!
    
    @IBOutlet var img_minus: UIButton!
    
    
    var incrementHandler: ButtonHandler?
    var decrementHandler: ButtonHandler?
    
    func configureWithValue(value: UInt, incrementHandler: ButtonHandler?, decrementHandler: ButtonHandler?) {
        itemQty.text = String(value)
        self.incrementHandler = incrementHandler
        self.decrementHandler = decrementHandler
    }
    
    @IBAction func increment(sender: AnyObject) {
        incrementHandler?(self)
        
        UIView.animateWithDuration(0.6 ,
                                   animations: {
                                    self.img_plus.transform = CGAffineTransformMakeScale(0.3, 0.3)
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.2){
                                        self.img_plus.transform = CGAffineTransformIdentity
                                        //sender.setImage(UIImage(named: "minus"), forState: UIControlState.Normal)
                                    }
        })
        print("incrementHandler \(itemQty.text)")
        
        
    }
    
    @IBAction func decrement(sender: AnyObject) {
        decrementHandler?(self)
        
        UIView.animateWithDuration(0.6 ,
                                   animations: {
                                    self.img_minus.transform = CGAffineTransformMakeScale(0.3, 0.3)
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.2){
                                        self.img_minus.transform = CGAffineTransformIdentity
                                        //sender.setImage(UIImage(named: "minus"), forState: UIControlState.Normal)
                                    }
        })
        print("decrementHandler")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  

}
