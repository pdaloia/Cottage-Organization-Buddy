//
//  AttendeesList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-19.
//

import Foundation

class Attendee: Codable, CottageModelProtocol {
    
    var name: String
    var firebaseUserID: String
    
    init(name: String, firebaseUserID: String) {
        self.name = name
        self.firebaseUserID = firebaseUserID
    }
    
}
