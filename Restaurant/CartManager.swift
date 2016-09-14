//
//  CartManager.swift
//  Restaurant
//
//  Created by Nizamuddeen on 9/14/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit

/// <#Description#>
class CartManager: NSObject {
    
    private var productsArray: [ProductObject] = []
    
    class var sharedInstance: CartManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: CartManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = CartManager()
        }
        return Static.instance!
    }
    
    func addProduct(product: ProductObject) {
        productsArray.append(product)
    }
    
    func removeProduct(product: ProductObject) -> Bool {
        if let index = productsArray.indexOf(product) {
            productsArray.removeAtIndex(index)
            return true
        }
        
        return false
    }
    
    func totalPriceInCart() -> Float {
        var totalPrice: Float = 0
        for product in productsArray {
            //totalPrice += product.rate.floatValue
        }
        return totalPrice
    }
    
    func productAtIndexPath(indexPath: NSIndexPath) -> ProductObject {
        return productsArray[indexPath.row]
    }
    
    func numberOfItemsInCart() -> Int {
        return ProductObject().name.count
    }
    
    func clearCart() {
        productsArray.removeAll(keepCapacity: false)
    }
    
    func isProductInCart(product: ProductObject) -> Bool {
        return productsArray.contains(product)
    }
    
}