//
//  CottageTrip.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

class CottageTrip {
    var tripName: String;
    var tripOrganiser: String;
    var groceryList: GroceryLists;
    var drinksList: DrinksList;
    var carsList: CarsList;
    var bedsList: BedsList;
    
    init() {
        self.tripName = "";
        self.tripOrganiser = "";
        self.groceryList = GroceryLists(groceries: []);
        self.drinksList = DrinksList(person: "", drinkNames: []);
        self.carsList = CarsList(carList: []);
        self.bedsList = BedsList(beds: []);
    }
}
