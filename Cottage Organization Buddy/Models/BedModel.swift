//
//  BedsList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

struct Bed: CottageModelProtocol {
    
    var size: BedSize
    var occupants: [Attendee]
    
    func checkIfBedAtRecommendedCapacity(bed: Bed) -> Bool {
        
        switch (bed.size, bed.occupants.count) {
        case (.twin, 0):
            return false
        case (.double, 0...1), (.queen, 0...1), (.king, 0...1):
            return false
        default:
            return true
        }
        
    }
    
}

enum BedSize {
    case twin, double, queen, king
}
