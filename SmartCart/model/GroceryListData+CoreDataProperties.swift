//
//  GroceryListData+CoreDataProperties.swift
//  SmartCart
//
//  Created by Zhyvel Maksim on 12/9/20.
//
//

import Foundation
import CoreData


extension GroceryListData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryListData> {
        return NSFetchRequest<GroceryListData>(entityName: "GroceryList")
    }

    @NSManaged public var products: [Product]?

}

extension GroceryListData : Identifiable {

}
