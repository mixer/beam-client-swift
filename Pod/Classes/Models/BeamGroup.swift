//
//  BeamGroup.swift
//  Beam API
//
//  Created by Jack Cook on 4/25/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

import UIKit

public enum BeamGroup: String {
    case Admin = "Admin"
    case Developer = "Developer"
    case GlobalMod = "GlobalMod"
    case Owner = "Owner"
    case Moderator = "Mod"
    case Pro = "Pro"
    case User = "User"
    
    public func getValue() -> Int {
        switch self {
        case .Admin:
            return 6
        case .Developer:
            return 5
        case .GlobalMod:
            return 4
        case .Owner:
            return 3
        case .Moderator:
            return 2
        case .Pro:
            return 1
        case .User:
            return 0
        }
    }
}

// TODO: Find somewhere to move these functions

public func chatColorForGroups(groups: [BeamGroup]) -> UIColor {
    if groups.contains(.Owner) {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    if groups.contains(.Admin) {
        return UIColor(red: 181/255, green: 37/255, blue: 53/255, alpha: 1)
    }
    
    if groups.contains(.Developer) {
        return UIColor(red: 236/255, green: 191/255, blue: 55/255, alpha: 1)
    }
    
    if groups.contains(.GlobalMod) {
        return UIColor(red: 36/255, green: 198/255, blue: 40/255, alpha: 1)
    }
    
    if groups.contains(.Moderator) {
        return UIColor(red: 55/255, green: 237/255, blue: 59/255, alpha: 1)
    }
    
    if groups.contains(.Pro) {
        return UIColor(red: 198/255, green: 66/255, blue: 234/255, alpha: 1)
    }
    
    return UIColor(red: 55/255, green: 170/255, blue: 213/255, alpha: 1)
}

public func getHighestGroup(groups: [BeamGroup]) -> BeamGroup {
    var highestGroup = BeamGroup.User
    for group in groups {
        if group.getValue() > highestGroup.getValue() {
            highestGroup = group
        }
    }
    
    return highestGroup
}
