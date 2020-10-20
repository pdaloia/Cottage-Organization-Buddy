//
//  CarsList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

struct Car: CottageModelProtocol {
    var driver: Attendee
    var numberOfPassengers: Int
    var passengers: [Attendee]
}
