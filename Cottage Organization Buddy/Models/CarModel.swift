//
//  CarsList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

struct Car: CottageModelProtocol {
    var driver: Attendee
    var numberOfSeats: Int
    var passengers: [Attendee]
    
    func returnPassengersNames() -> String {
        
        var passengersNames: [String] = []
        for passenger in self.passengers {
            passengersNames.append(passenger.name)
        }
        return passengersNames.joined(separator: ", ")
        
    }
}

