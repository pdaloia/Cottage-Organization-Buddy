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
    var roomsList: [Room] = []
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
    
    func checkIfAttendeeCanRequestCarSpot(_ attendee: Attendee, _ car: Car) -> Bool {
        
        //check if car is at max capacity
        if car.calculateRemainingSeats() <= 0 {
            return false
        }
        
        //check if attendee is a driver
        if self.carsList.contains(where: { $0.driver === attendee }) {
            return false
        }
        
        //check if attendee already requested a spot in this car
        if car.requests.contains(where: { $0.requester === attendee }) {
            return false
        }
        
        //check if attendee is a passenger in another car
        //Very bad implementation, please make more efficient in future rather than searching through all passengers.
        for car in self.carsList {
            if car.passengers.contains(where: { $0 === attendee }) {
                return false
            }
        }
        
        //if no above conditions return false, we can return true here
        return true
        
    }
    
    func removeAllCarRequests(for attendee: Attendee) {
        for car in self.carsList {
            car.requests.removeAll(where: { $0.requester === attendee })
        }
    }
    
}
