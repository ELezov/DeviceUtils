//
//  BatteryInfoModel.swift
//  EasyDeviceUtils
//
//  Created by EugenKGD on 02/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import UIKit

// https://developer.apple.com/documentation/uikit/uidevice/1620051-batterystate?language=swift

public struct BatteryInfoModel {
    
    enum BatteryState {
        // If battery monitoring is not enabled
        case unknown
        // The device is not plugged into power; the battery is discharging.
        case unplugged(Int)
        // The device is plugged into power and the battery
        // is less than 100% charged.
        case charging(Int)
        // The device is plugged into power and the battery is 100% charged.
        case full(Int)
        /// BatteryLevel return - 1
        case simulator
    }
    
    var state: BatteryState {
        let level = UIDevice.current.batteryLevel
        let batteryState = UIDevice.current.batteryState
        
        let levelInPercent = Int(round(level * 100))
        
        switch batteryState {
        case .unknown:
            return level == -1.0 ? .simulator : .unknown
        case .unplugged:
            return .unplugged(levelInPercent)
        case .charging:
            return .charging(levelInPercent)
        case .full:
            return .full(levelInPercent)
        @unknown default:
            assertionFailure()
            return .unknown
        }
    }
    
    var batteryLevel: Int {
        switch state {
        case .charging(let level),
             .unplugged(let level),
             .full(let level):
            return level
        case .simulator,
             .unknown:
            return 100
        }
    }
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
}
