//
//  BatteryInfoModel.swift
//  EasyDeviceUtils
//
//  Created by EugenKGD on 02/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import UIKit

public struct BatteryInfoModel {
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    // The battery state for the device. (unknown, unplugged, charging, full)
    public var state: UIDevice.BatteryState {
        return UIDevice.current.batteryState
    }
    
    // The battery charge level for the device.
    // in range 0...1, -1 for simulators
    public var level: Float {
        return UIDevice.current.batteryLevel
    }
}
