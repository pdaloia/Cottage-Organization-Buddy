//
//  CarsList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

struct CarsList {
    var carList: [Car];
}

struct Car {
    var driverName: String;
    var numberOfPassengers: Int;
    var passengers: [String];
}
