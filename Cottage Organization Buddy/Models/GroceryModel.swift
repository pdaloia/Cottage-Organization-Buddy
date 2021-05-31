//
//  GroceryList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

class GroceryLists: Codable, CottageModelProtocol {
    var allItems: [Grocery]
    var groceryLists: [Attendee:[Grocery]]
    
    init(allItems: [Grocery], groceryLists: [Attendee:[Grocery]]) {
        self.allItems = allItems
        self.groceryLists = groceryLists
    }
}

class Grocery: Codable {
    var productName: String
    var price: Double
    var quantity: Int
    var assignedTo: Attendee
    
    init(productName: String, price: Double, quantity: Int, assignedTo: Attendee) {
        self.productName = productName
        self.price = price
        self.quantity = quantity
        self.assignedTo = assignedTo
    }
}

enum GroceryType: String, Codable {
    case produce, meat, snack, premade, drink, miscellaneous /*cheese,*/
}
