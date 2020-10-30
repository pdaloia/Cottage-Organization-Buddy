//
//  DrinksList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

struct PersonalDrinksList: CottageModelProtocol {
    var person: Attendee
    var drinkNames: [Drink]
}

struct Drink {
    var name: String
    var isAlcoholic: Bool
    var forSharing: Bool
}
