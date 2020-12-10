//
//  File.swift
//  SmartCart
//
//  Created by Zhyvel Maksim on 11/20/20.
//

import Foundation

public class Product : NSObject, NSCoding
{
    public func encode(with coder: NSCoder) {
        coder.encode(Name, forKey: "name")
        coder.encode(CreateDate, forKey: "createDate")
        coder.encode(TermOfKeep, forKey: "termOfKeep")
        coder.encode(quantity, forKey: "quantity")
    }
    
    public init(product name: String, created createDate: Date?, for termOfKeep: Int?, _ Quantity: Int = 1) {
        Name = name
        CreateDate = createDate
        TermOfKeep = termOfKeep
        quantity = Quantity
    }
    
    public required init?(coder: NSCoder) {
        Name = coder.decodeObject(forKey: "name") as! String
        CreateDate = coder.decodeObject(forKey: "createDate") as! Date?
        TermOfKeep = coder.decodeObject(forKey: "termOfKeep") as! Int?
        quantity = coder.decodeInteger(forKey:  "quantity") 
    }
    
    var Name: String = ""
    var CreateDate: Date?
    var TermOfKeep: Int?
    var quantity: Int
    var daysToExpire: Int {
        let calendar = NSCalendar.current
        let currentDate = calendar.startOfDay(for: Date())
        let createDate = calendar.startOfDay(for: CreateDate!)
        let components = calendar.dateComponents([.day], from: createDate, to: currentDate)
        return TermOfKeep! - components.day!
    }
    
    
    public func decreaseQuantity(){
        if quantity > 1
        {
            quantity -= 1
        }
    }
    
    public func increaseQuantity(){
        quantity += 1
    }
}
