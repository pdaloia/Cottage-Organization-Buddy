//
//  CottageTrip.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

class CottageTrip: CottageModelProtocol {
    var tripName: String = ""
    var tripOrganiser: Attendee = Attendee(name: "")
    var startDate: Date = Date()
    var endDate: Date = Date()
    var address: String = ""
    var attendeesList: [Attendee] = []
    var groceryList: GroceryLists = GroceryLists(allItems: [], groceriesPerPerson: [])
    var drinksList: [PersonalDrinksList] = []
    var carsList: [Car] = []
    var bedsList: [Bed] = []
}


extension CottageTrip {
    
    func returnSharedDrinksList() -> [Drink] {
        
        var allSharedDrinks: [Drink]
        allSharedDrinks = []
        
        for personalList in drinksList {
            for drink in personalList.drinkNames {
                if drink.forSharing{
                    allSharedDrinks.append(drink)
                }
            }
        }
        
        return allSharedDrinks
        
    }
    
}
