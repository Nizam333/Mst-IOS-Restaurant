//
//  MenuTableViewCell.swift
//  Restaurant
//
//  Created by Suriya on 7/22/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    
    @IBOutlet var itemImage: UIImageView!
    
    @IBOutlet var itemPrice: UILabel!
  
    @IBOutlet var itemName: UILabel!
   
    
    @IBOutlet var itemAddCart: UIButton!
   
  
   // @IBOutlet var itemCart: UIImageView!
    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
      //  let destination = MenuViewController() // Your destination
        //navigationController?.pushViewController(destination, animated: true)
        // Configure the view for the selected state
    }

}
