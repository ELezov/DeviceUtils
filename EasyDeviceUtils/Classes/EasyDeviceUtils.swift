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
    
    public static var GMToffset: Int {
        return TimeZone.current.secondsFromGMT() / 3600
    }
    
    public static var localeCode: String? {
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
    public static var appIdentifier: String? {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
    }
    
    // An alphanumeric string that uniquely identifies a device to the app’s vendor.
    // For examle: "FDE442FD-6B1E-4AFD-B8BF-F87F699EDFA2"
    public static var uniqueIdentifier: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    // e.g. "My iPhone"
    public static var userDeviceName: String {
        return UIDevice.current.name
    }
    
    public static var modelIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
                
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    public static var systemInfo: SystemInfo {
        return SystemInfo()
    }
    
    public static var battery: Battery {
        return Battery()
    }
    
    public static var model: Model {
        return Model()
    }
    
    public static var cpu: CPU {
        return CPU()
    }
    
    public static var processInfo: ProcessInfoModel {
        return ProcessInfoModel()
    }
    
    public static var carrier: Carrier {
        return Carrier()
    }
    
    public static var wifi: Wifi {
        return Wifi()
    }
    
    public static var diskSpace: DiskSpace {
        return DiskSpace()
    }
    
    public static var screen: Screen {
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
