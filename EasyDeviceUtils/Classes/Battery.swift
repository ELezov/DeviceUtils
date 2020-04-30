//
//  Battery.swift
//  EasyDeviceUtils
//
//  Created by EugenKGD on 02/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import UIKit

// https://developer.apple.com/documentation/uikit/uidevice/1620051-batterystate?language=swift

public struct Battery {
    
    public enum State: Equatable {
        /// If battery monitoring is not enabled
        case unknown
        /// The device is not plugged into power; the battery is discharging.
        case unplugged(Int)
        /// The device is plugged into power and the battery
        /// is less than 100% charged.
        case charging(Int)
        /// The device is plugged into power and the battery is 100% charged.
        case full(Int)
        /// BatteryLevel return - 1
        case simulator
        
        public var description: String {
            switch self {
            case .unknown:
                return "Unknown battery"
            case .unplugged(let level):
                return "Battery is unplugged with \(level) percent"
            case .charging(let level):
                return "Battery is charging with \(level) percent"
            case .full(let level):
                return "Battery is full with \(level) percent"
            case .simulator:
                return "Battery of simulator"
            }
        }
        
        public var level: Int {
            switch self {
            case .charging(let level),
                 .unplugged(let level),
                 .full(let level):
                return level
            case .simulator,
                 .unknown:
                return 100
            }
        }
    }
    
    public var state: State {
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
    
    
    // https://developer.apple.com/documentation/foundation/nsprocessinfo/1617047-lowpowermodeenabled
    public var lowPowerModeEnabled: Bool {
        return ProcessInfo.processInfo.isLowPowerModeEnabled
    }
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
}

public func < (lhs: Battery.State, rhs: Battery.State) -> Bool {
  switch (lhs, rhs) {
  case (.full, _): return false // return false (even if both are `.Full` -> they are equal)
  case (_, .full): return true // lhs is *not* `.Full`, rhs is
  case let (.charging(lhsLevel), .charging(rhsLevel)): return lhsLevel < rhsLevel
  case let (.charging(lhsLevel), .unplugged(rhsLevel)): return lhsLevel < rhsLevel
  case let (.unplugged(lhsLevel), .charging(rhsLevel)): return lhsLevel < rhsLevel
  case let (.unplugged(lhsLevel), .unplugged(rhsLevel)): return lhsLevel < rhsLevel
  default: return false // compiler won't compile without it, though it cannot happen
  }
}
