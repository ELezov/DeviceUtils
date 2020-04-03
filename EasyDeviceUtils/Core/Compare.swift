//
//  Compare.swift
//  DeviceUtils
//
//  Created by EugenKGD on 15/11/2019.
//  Copyright © 2019 ELezov. All rights reserved.
//

import Foundation

func ==(lhs: ScreenInfoModel.Scale, rhs: ScreenInfoModel.Scale) -> Bool {
     guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
     return lhs.rawValue == rhs.rawValue
}

func <(lhs: ScreenInfoModel.Scale, rhs: ScreenInfoModel.Scale) -> Bool {
     guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
     return lhs.rawValue < rhs.rawValue
 }

func >(lhs: ScreenInfoModel.Scale, rhs: ScreenInfoModel.Scale) -> Bool {
     guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
     return lhs.rawValue > rhs.rawValue
 }

func <=(lhs: ScreenInfoModel.Scale, rhs: ScreenInfoModel.Scale) -> Bool {
     guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
     return lhs.rawValue <= rhs.rawValue
 }

func >=(lhs: ScreenInfoModel.Scale, rhs: ScreenInfoModel.Scale) -> Bool {
     guard lhs.rawValue > 0 && rhs.rawValue > 0 else { return false }
     return lhs.rawValue >= rhs.rawValue
 }
