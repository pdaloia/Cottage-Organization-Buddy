//
//  CarsList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

class Car: CottageModelProtocol {
    var driver: Attendee
    var numberOfSeats: Int
    var passengers: [Attendee]
    
    init(driver: Attendee, numberOfSeats: Int, passengers: [Attendee]) {
        self.driver = driver
        self.numberOfSeats = numberOfSeats
        self.passengers = passengers
    }
    
    func returnPassengersNames() -> String {
        
        var passengersNames: [String] = []
        for passenger in self.passengers {
            passengersNames.append(passenger.name)
        }
        return passengersNames.joined(separator: ", ")
        
    }
    
    func calculateRemainingSeats() -> Int {
        return self.numberOfSeats - self.passengers.count
    }
}

