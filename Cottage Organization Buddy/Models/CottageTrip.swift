//
//  CottageTrip.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

class CottageTrip {
    var tripName = ""
    var tripOrganiser = ""
    var groceryList = GroceryLists(allItems: [], groceriesPerPerson: [])
    var drinksList: [PersonalDrinksList] = []
    var carsList: [Car] = []
    var bedsList: [Bed] = []
}
