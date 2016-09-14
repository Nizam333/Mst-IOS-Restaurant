//
//  ProductObject.swift
//  Restaurant
//
//  Created by Nizamuddeen on 9/14/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit

class ProductObject: NSObject {
    
    
    var name:[String] = []
    var rate:[String] = []
    var image:[String] = []
    var qty:[Int] = []
    
    
   /* init(name: [String], rate: [String], image: [String], qty:[Int]) {
        self.name = name
        self.rate = rate
        self.image = image
        self.qty = qty
    }*/
    
    func name_set(value:String){
    
        name.append(value)
    }
    func name_get(position:Int) -> String {
        let name = self.name[position]
        
        return name
        
    }

}
