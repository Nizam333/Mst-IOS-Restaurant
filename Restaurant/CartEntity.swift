//
//  CartEntity.swift
//
//
//  Created by Nizamuddeen on 9/15/16.
//
//

import Foundation
import CoreData


class CartEntity: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclass
    
    @NSManaged var pro_name: String?
    @NSManaged var pro_rate: String?
    @NSManaged var pro_catid: String?
    @NSManaged var pro_id: String?
    @NSManaged var pro_image: String?
    @NSManaged var pro_desc: String?
    
}
