//
//  UserService.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-28.
//

import Foundation
import Firebase

class UserService {
    
    //The service used to get the currently logged in user's attendee model
    static func GetLoggedInUser(model: CottageTrip) throws -> Attendee {
        
        var currentLoggedInUser: Attendee
        
        if let user = model.attendeesList.first(where: { $0.firebaseUserID == Auth.auth().currentUser?.uid }) {
            currentLoggedInUser = user
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
