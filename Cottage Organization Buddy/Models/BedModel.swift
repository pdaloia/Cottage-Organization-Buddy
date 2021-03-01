//
//  BedsList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

class Bed: CottageModelProtocol {
    
    var size: BedSize
    
    init(size: BedSize, occupants: [Attendee]) {
        
        self.size = size
        
    }
    
}

enum BedSize {
    case twin, double, queen, king
}
