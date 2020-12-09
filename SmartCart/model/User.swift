//
//  User.swift
//  SmartCart
//
//  Created by Zhyvel Maksim on 11/21/20.
//

import Foundation

public class User
{
    var Name: String
    var DateOfBirth: Date
    var Weight : Double
    
    init(_ name: String, born dateOfBirth: Date, weight: Double) {
        Name = name
        DateOfBirth = dateOfBirth
        Weight = weight
    }
    
    public func ChangeProfile(name: String, dateOfBirth: Date, weight: Double)
    {
        Name = name
        DateOfBirth = dateOfBirth
        Weight = weight
    }
}
