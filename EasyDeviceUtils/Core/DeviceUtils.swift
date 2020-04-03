//
//  FraudHelper.swift
//  FraudResearch
//
//  Created by EugenKGD on 12/11/2019.
//  Copyright © 2019 ELezov. All rights reserved.
//

import Foundation
import UIKit
// for carrier
import CoreTelephony


class DeviceUtils {
    
    static var shared: DeviceUtils = {
        let instance = DeviceUtils()
        return instance
    }()
    
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #endif
        return false
    }
    
    var GMToffset: Int {
        return TimeZone.current.secondsFromGMT() / 3600
    }
    
    var localeCode: String? {
        return Locale.current.regionCode
    }
}

extension DeviceUtils: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

extension DeviceUtils {
    
    var appIdentifier: String? {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
    }
    
    // An alphanumeric string that uniquely identifies a device to the app’s vendor.
    var uniqueIdentifier: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    // e.g. "My iPhone"
    var userDeviceName: String {
        return UIDevice.current.name
    }
    
    var systemInfo: SystemInfo {
        return SystemInfo()
    }
    
    var batteryInfo: BatteryInfoModel {
        return BatteryInfoModel()
    }
    
    var modelInfo: ModelInfoModel {
        return ModelInfoModel()
    }
    
    var cpuInfoModel: CPUInfoModel {
        return CPUInfoModel()
    }
    
    var processInfoModel: ProcessInfoModel {
        return ProcessInfoModel()
    }
    
    var carrierInfoModel: CarrierInfoModel {
        return CarrierInfoModel()
    }
    
    var wifiInfoModel: WifiInfoModel {
        return WifiInfoModel()
    }
    
    var diskSpaceInfo: DiskSpaceModel {
        return DiskSpaceModel()
    }
    
    struct SystemInfo {
        // @"iOS"
        var systemName: String {
            return UIDevice.current.systemName
        }
        
        // e.g. @"4.0"
        var systemVersion: String {
            return UIDevice.current.systemVersion
        }
    }
}
