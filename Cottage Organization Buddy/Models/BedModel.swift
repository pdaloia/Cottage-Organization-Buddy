//
//  BedsList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

struct Bed: CottageModelProtocol {
    
    var size: BedSize
    var capacity: Int
    var occupants: [Attendee]
}

enum BedSize {
    case twin, double, queen, king
}
