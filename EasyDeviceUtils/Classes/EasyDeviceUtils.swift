//
//  EasyDeviceUtils.swift
//  EasyDeviceUtils
//
//  Created by EugenKGD on 12/11/2019.
//  Copyright © 2019 ELezov. All rights reserved.
//

import Foundation
import UIKit
// for carrier
import CoreTelephony


public class EasyDeviceUtils {
    
    public static var shared: EasyDeviceUtils = {
        let instance = EasyDeviceUtils()
        return instance
    }()
    
    public static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    public var GMToffset: Int {
        return TimeZone.current.secondsFromGMT() / 3600
    }
    
    public var localeCode: String? {
        return Locale.current.regionCode
    }
}

extension EasyDeviceUtils: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

extension EasyDeviceUtils {
    
    // For example: "com.elezov.deviceUtils"
    public var appIdentifier: String? {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
    }
    
    // An alphanumeric string that uniquely identifies a device to the app’s vendor.
    // For examle: "FDE442FD-6B1E-4AFD-B8BF-F87F699EDFA2"
    public var uniqueIdentifier: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    // e.g. "My iPhone"
    public var userDeviceName: String {
        return UIDevice.current.name
    }
    
    public var systemInfo: SystemInfo {
        return SystemInfo()
    }
    
    static public var battery: Battery {
        return Battery()
    }
    
    public var modelInfo: ModelInfoModel {
        return ModelInfoModel()
    }
    
    public var cpuInfo: CPUInfoModel {
        return CPUInfoModel()
    }
    
    public var processInfo: ProcessInfoModel {
        return ProcessInfoModel()
    }
    
    public var carrierInfo: CarrierInfoModel {
        return CarrierInfoModel()
    }
    
    public var wifiInfo: WifiInfoModel {
        return WifiInfoModel()
    }
    
    public var diskSpace: DiskSpaceModel {
        return DiskSpaceModel()
    }
    
    static public var screen: Screen {
        return Screen()
    }
    
    public struct SystemInfo {
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
