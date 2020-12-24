//
//  DrinksList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

class PersonalDrinksList: CottageModelProtocol {
    var person: Attendee
    var drinkNames: [Drink]
    
    init(person: Attendee, drinkNames: [Drink]) {
        self.person = person
        self.drinkNames = drinkNames
    }
}

struct Drink {
    var name: String
    var isAlcoholic: Bool
    var forSharing: Bool
}
