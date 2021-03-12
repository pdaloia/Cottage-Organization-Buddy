//
//  RoomModel.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-02-28.
//

import Foundation

class Room: Codable, CottageModelProtocol {
    
    var bedList: [Bed]
    
    init(bedList: [Bed]) {
        
        self.bedList = bedList
        
    }
    
}
