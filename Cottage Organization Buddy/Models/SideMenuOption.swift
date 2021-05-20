//
//  SideMenuOption.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-20.
//

import UIKit

enum SideMenuOption: Int, CustomStringConvertible {
    
    case Profile
    case SelectCottage
    case Settings
    case Logout
    
    var description: String {
        switch self {
        case .Profile:
            return "Profile"
        case .SelectCottage:
            return "Select Cottage"
        case .Settings:
            return "Settings"
        case .Logout:
            return "Logout"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Profile:
            return UIImage(systemName: "person.fill") ?? UIImage()
        case .SelectCottage:
            return UIImage(systemName: "house.fill") ?? UIImage()
        case .Settings:
            return UIImage(systemName: "gearshape.fill") ?? UIImage()
        case .Logout:
            return UIImage(systemName: "power") ?? UIImage()
        }
    }
    
}
