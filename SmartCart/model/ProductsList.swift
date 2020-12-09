//
//  ProductList.swift
//  SmartCart
//
//  Created by Zhyvel Maksim on 11/20/20.
//

import Foundation

public class ProductsList
{
    var NameOfList: String
    var ProductList: [Product] = []
    var CloseToExpire: Int = 0
    
    init(list name: String) {
        NameOfList = name
    }
    
    func addProduct(named name: String, days: Int)
    {
        ProductList.append(Product(product: name,created: Date() ,for: days))
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
    
}
