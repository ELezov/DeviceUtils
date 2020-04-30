//
//  Compare.swift
//  EasyDeviceUtils
//
//  Created by EugenKGD on 15/11/2019.
//  Copyright © 2019 ELezov. All rights reserved.
//

import Foundation

public func ==(lhs: Screen.Scale, rhs: Screen.Scale) -> Bool {
    guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
    return lhs.rawValue == rhs.rawValue
}

public func <(lhs: Screen.Scale, rhs: Screen.Scale) -> Bool {
    guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
    return lhs.rawValue < rhs.rawValue
}

public func >(lhs: Screen.Scale, rhs: Screen.Scale) -> Bool {
    guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
    return lhs.rawValue > rhs.rawValue
}

public func <=(lhs: Screen.Scale, rhs: Screen.Scale) -> Bool {
    guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
    return lhs.rawValue <= rhs.rawValue
}

public func >=(lhs: Screen.Scale, rhs: Screen.Scale) -> Bool {
    guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
    return lhs.rawValue >= rhs.rawValue
}
