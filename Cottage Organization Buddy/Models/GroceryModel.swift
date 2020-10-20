//
//  GroceryList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

struct GroceryLists {
    var allItems: [Grocery]
    var groceriesPerPerson: [GroceryList]
}

struct GroceryList {
    var personsName: Attendee
    var groceries: [Grocery]
}

struct Grocery {
    var productName: String
    var price: Double
    var Quantity: Int
}
