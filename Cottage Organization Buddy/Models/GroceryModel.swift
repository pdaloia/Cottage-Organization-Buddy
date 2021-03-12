//
//  GroceryList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

class GroceryLists: Codable, CottageModelProtocol {
    var allItems: [Grocery]
    var groceriesPerPerson: [GroceryList]
    
    init(allItems: [Grocery], groceriesPerPerson: [GroceryList]) {
        self.allItems = allItems
        self.groceriesPerPerson = groceriesPerPerson
    }
}

class GroceryList: Codable {
    var person: Attendee
    var groceries: [Grocery]
    
    init(person: Attendee, groceries: [Grocery]) {
        self.person = person
        self.groceries = groceries
    }
}

class Grocery: Codable {
    var productName: String
    var price: Double
    var quantity: Int
    
    init(productName: String, price: Double, quantity: Int) {
        self.productName = productName
        self.price = price
        self.quantity = quantity
    }
}

enum GroceryType: String, Codable {
    case produce, meat, snack, premade, drink, miscellaneous /*cheese,*/
}
