//
//  OrdersTableViewCell.swift
//  Restaurant
//
//  Created by Nizamuddeen on 9/2/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet var tv_orderId: UILabel!
    
    @IBOutlet var tv_orderDate: UILabel!
    
    @IBOutlet var tv_orderStatus: UILabel!
    
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
