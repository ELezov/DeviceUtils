//
//  Compare.swift
//  DeviceUtils
//
//  Created by EugenKGD on 15/11/2019.
//  Copyright © 2019 ELezov. All rights reserved.
//

import Foundation


func ==(lhs: DeviceUtils.ScreenModel.Scale, rhs: DeviceUtils.ScreenModel.Scale) -> Bool {
     guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
     return lhs.rawValue == rhs.rawValue
}

func <(lhs: DeviceUtils.ScreenModel.Scale, rhs: DeviceUtils.ScreenModel.Scale) -> Bool {
     guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
     return lhs.rawValue < rhs.rawValue
 }

func >(lhs: DeviceUtils.ScreenModel.Scale, rhs: DeviceUtils.ScreenModel.Scale) -> Bool {
     guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
     return lhs.rawValue > rhs.rawValue
 }

func <=(lhs: DeviceUtils.ScreenModel.Scale, rhs: DeviceUtils.ScreenModel.Scale) -> Bool {
     guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
     return lhs.rawValue <= rhs.rawValue
 }

func >=(lhs: DeviceUtils.ScreenModel.Scale, rhs: DeviceUtils.ScreenModel.Scale) -> Bool {
     guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
     return lhs.rawValue >= rhs.rawValue
 }
