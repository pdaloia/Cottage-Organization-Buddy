//
//  CarsList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

class Car: Codable, CottageModelProtocol {
    var driver: Attendee
    var numberOfSeats: Int
    var passengers: [Attendee]
    var requests : [CarRequest]
    
    init(driver: Attendee, numberOfSeats: Int, passengers: [Attendee], requests: [CarRequest]) {
        
        self.driver = driver
        self.numberOfSeats = numberOfSeats
        self.passengers = passengers
        self.requests = requests
        
    }
    
    func returnPassengersNames() -> String {
        
        if self.passengers.count == 0 {
            return "No passengers yet"
        }
        
        var passengersNames: [String] = []
        for passenger in self.passengers {
            passengersNames.append(passenger.name)
        }
        return passengersNames.joined(separator: ", ")
        
    }
    
    func calculateRemainingSeats() -> Int {
        
        return self.numberOfSeats - self.passengers.count
        
    }
    
    func createRequest(for attendeee: Attendee) {
        
        let newRequest = CarRequest(requester: attendeee)
        self.requests.append(newRequest)
        
    }
    
}

