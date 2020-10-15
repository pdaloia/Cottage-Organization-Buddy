//
//  GroceryList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

struct GroceryLists {
    var groceries: [GroceryList];
}

struct GroceryList {
    var personsName: String;
    var groceries: [Grocery];
}

struct Grocery {
    var productName: String;
    var price: Double;
}
