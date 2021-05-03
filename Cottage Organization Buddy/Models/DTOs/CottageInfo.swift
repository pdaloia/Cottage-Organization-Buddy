//
//  CottageInfo.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-02.
//

import Foundation

class CottageInfo {
    
    var CottageID: String
    var CottageName: String
    var CottageOrganizer: Attendee
    
    init(cottageID: String, cottageName: String, cottageOrganiser: Attendee) {
        self.CottageID = cottageID
        self.CottageName = cottageName
        self.CottageOrganizer = cottageOrganiser
    }
    
}
