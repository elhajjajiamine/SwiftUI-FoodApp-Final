//
//  Cart.swift
//  SwiftUI FoodApp
//
//  Created by elhajjaji on 10/29/20.
//

import SwiftUI

struct Cart: Identifiable{
    
    var id = UUID().uuidString
    var  item : Item
    var quantity : Int
}
