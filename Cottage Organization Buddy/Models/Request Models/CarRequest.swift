//
//  CarRequest.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-01-31.
//

import Foundation

class CarRequest: Codable, RequestProtocol {
    
    private(set) var requester: Attendee
    
    init(requester: Attendee) {
        self.requester = requester
    }
    
}
