//
//  StorageList.swift
//  SmartCart
//
//  Created by Zhyvel Maksim on 11/26/20.
//

import Foundation

public class StorageList
{
    var ListOfProductLists : [ProductsList]
    
    init() {
        ListOfProductLists = []
    }
    
    func addList(named name: String){
        ListOfProductLists.append(ProductsList(list: name))
    }    
}
