//
//  AttendeesList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-19.
//

import Foundation

class Attendee: Codable, CottageModelProtocol {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
}
