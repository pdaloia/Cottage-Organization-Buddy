//
//  AttendeesList.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-19.
//

import Foundation

class Attendee: Hashable, Codable, CottageModelProtocol {
        
    var name: String
    var firebaseUserID: String
    
    init(name: String, firebaseUserID: String) {
        self.name = name
        self.firebaseUserID = firebaseUserID
    }
        
    //implementations needed for hashing (Attendee will be used as keys in dictionaries)
    static func == (lhs: Attendee, rhs: Attendee) -> Bool {
        
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
        
    }
    
    public func hash(into hasher: inout Hasher) {
        
        hasher.combine(ObjectIdentifier(self).hashValue)
        
    }
    
}
