//
//  CartProductViewCell.swift
//  Restaurant
//
//  Created by Nizamuddeen on 9/14/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit

class CartProductViewCell: UITableViewCell {

    @IBOutlet var productImageView: UIView!
    
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   // productCell.itemNameLabel.text = product.name
  //  productCell.itemPriceLabel.text = productPriceFormatter.
        //productCell.productImageView.hnk_setImageFromURL(imageURL)

}
