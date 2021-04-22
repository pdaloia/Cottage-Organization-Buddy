//
//  RoomModel.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-02-28.
//

import Foundation

class Room: Codable, CottageModelProtocol {
    
    var bedDict: [String : Int]
    
    init(bedDict: [String : Int]) {
        
        self.bedDict = bedDict
        
    }
    
}
