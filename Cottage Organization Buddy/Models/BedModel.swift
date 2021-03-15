//
//  BedsList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import Foundation

class Bed: Codable, CottageModelProtocol {
    
    var size: BedSize
    
    init(size: BedSize) {
        
        self.size = size
        
    }
    
}

enum BedSize: String, Codable {
    
    case twin, double, queen, king
}
