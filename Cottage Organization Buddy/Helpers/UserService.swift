//
//  UserService.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-28.
//

import Foundation

class UserService {
    
    //The service used to get the currently logged in user's attendee model
    //will be hard-coded to my user for now
    static func GetLoggedInUser(model: CottageTrip) throws -> Attendee {
        
        var currentLoggedInUser: Attendee
        
        if let getUser = model.attendeesList.first(where: {$0.name == "Phil"}) {
            currentLoggedInUser = getUser
        }
        else {
            throw UserError.cantFindUserError
        }
        
        return currentLoggedInUser
        
    }
    
}

enum UserError: Error {
    case cantFindUserError
}
