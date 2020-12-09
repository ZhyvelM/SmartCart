//
//  GroceryList.swift
//  SmartCart
//
//  Created by Zhyvel Maksim on 11/21/20.
//

import Foundation
import CoreData

extension GroceryList
{
    @NSManaged var ProductList: [Product]
    
    func addProduct(named name: String){
        ProductList.append(Product(product: name,created: nil,for: nil))
    }
    
    func reduceQuantity(of name: String){
        if let product = ProductList.filter({$0.Name == name}).first
        {
            product.decreaseQuantity()
        }
    }
    
    func increaseQuantity(of name: String){
        if let product = ProductList.filter({$0.Name == name}).first
        {
            product.increaseQuantity()
        }
    }
    
    func removeProduct(named name:String){
        ProductList.removeAll {$0.Name == name}
    }
}
