//
//  BedsList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

struct Bed {
    var size: BedSize
    var capacity: String
    var occupants: [String]
}

enum BedSize {
    case twin, double, queen, king
}
