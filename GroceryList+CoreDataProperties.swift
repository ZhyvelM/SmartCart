//
//  GroceryList+CoreDataProperties.swift
//  SmartCart
//
//  Created by Zhyvel Maksim on 12/9/20.
//
//

import Foundation
import CoreData


extension GroceryList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryList> {
        return NSFetchRequest<GroceryList>(entityName: "GroceryList")
    }

    @NSManaged public var products: [Product]?

}

extension GroceryList : Identifiable {

}
