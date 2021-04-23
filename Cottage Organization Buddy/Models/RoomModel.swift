//
//  RoomModel.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-02-28.
//

import Foundation

class Room: Codable, CottageModelProtocol {
    
    var bedDict: [String : Int]
    var roomID: String
    
    init(bedDict: [String : Int], roomID: String) {
        
        self.bedDict = bedDict
        self.roomID = roomID
        
    }
    
}
