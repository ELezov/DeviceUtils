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
// for wifi
import SystemConfiguration.CaptiveNetwork

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
    
    var batteryInfo: BatteryInfo {
        return BatteryInfo()
    }
    
    var modelInfo: ModelInfo {
        return ModelInfo()
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
    
    var diskSpaceInfo: DiskSpaceInfo {
        return DiskSpaceInfo()
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
    
    struct ScreenModel {
        
        public enum Screen: CGFloat {
            case unknown     = 0
            case inches_3_5  = 3.5
            case inches_4_0  = 4.0
            case inches_4_7  = 4.7
            case inches_5_5  = 5.5
            case inches_5_8  = 5.8 // iPhone X diagonal
            case inches_6_1  = 6.1
            case inches_6_5  = 6.5
            case inches_7_9  = 7.9
            case inches_9_7  = 9.7
            case inches_12_9 = 12.9

            /// Return screen family
            public var family: ScreenFamily {
                switch self {
                case .inches_3_5,
                     .inches_4_0:
                    return .old
                    
                case .inches_4_7:
                    return .small

                case .inches_5_5,
                     .inches_7_9,
                     .inches_5_8,
                     .inches_6_1,
                     .inches_6_5:
                    return .medium

                case .inches_9_7,
                     .inches_12_9:
                    return .big

                case .unknown:
                    return .unknown
                }
            }
        }
        
        enum Scale: CGFloat, Comparable, Equatable {
            case x1      = 1.0
            case x2      = 2.0
            case x3      = 3.0
            case unknown = 0
        }
        
        var scale: Scale {
            let scale = UIScreen.main.scale

            switch scale {
            case 1.0:
                return .x1

            case 2.0:
                return .x2

            case 3.0:
                return .x3

            default:
                return .unknown
            }
        }

        /// Return `true` for retina displays
        var isRetina: Bool {
            return scale > Scale.x1
        }
        
        
        enum ScreenFamily: String {
            case unknown = "unknown"
            case old     = "old"
            case small   = "small"
            case medium  = "medium"
            case big     = "big"
        }
        
        var brightness: CGFloat {
            return UIScreen.main.brightness
        }
        
        /// Return `true` for landscape interface orientation
        var isLandscape: Bool {
            return ( UIApplication.shared.statusBarOrientation == .landscapeLeft
                || UIApplication.shared.statusBarOrientation == .landscapeRight )
        }

        /// Return `true` for portrait interface orientation
        var isPortrait: Bool {
            return !isLandscape
        }
        
        var screen: Screen {
            let size = UIScreen.main.bounds.size
            let height = max(size.width, size.height)

            switch height {
            case 480:
                return .inches_3_5

            case 568:
                return .inches_4_0

            case 667:
                return ( scale == .x3 ? .inches_5_5 : .inches_4_7 )

            case 736:
                return .inches_5_5

            case 812:
                return .inches_5_8

            case 896:
                return ( scale == .x3 ? .inches_6_5 : .inches_6_1 )

            case 1024:
                if DeviceUtils.shared.modelInfo.isIpadMini {
                    return .inches_7_9
                } else {
                    return .inches_9_7
                }

            case 1366:
                return .inches_12_9

            default:
                return .unknown
            }
        }
        
        
    }
    
    struct ModelInfo {
        // e.g. @"iPhone", @"iPod touch"
        var modelString: String {
            return UIDevice.current.model
        }
        
        // e.g. @"iPhone 8 Plus"
        var modelDevice: String {
            return getModelByDevice()
        }
        
        var isIpadMini: Bool {
            return ["iPad Mini",
                    "iPad Mini 2",
                    "iPad Mini 3",
                    "iPad Mini 4"].contains(getModelByDevice())
        }
        
        private func getModelByDevice() -> String {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                    guard let value = element.value as? Int8, value != 0 else { return identifier }
                    return identifier + String(UnicodeScalar(UInt8(value)))
            }
           
            func mapToDevice(identifier: String) -> String {
                #if os(iOS)
                switch identifier {
                case "iPod5,1":                                 return "iPod Touch 5"
                case "iPod7,1":                                 return "iPod Touch 6"
                case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
                case "iPhone4,1":                               return "iPhone 4s"
                case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
                case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
                case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
                case "iPhone7,2":                               return "iPhone 6"
                case "iPhone7,1":                               return "iPhone 6 Plus"
                case "iPhone8,1":                               return "iPhone 6s"
                case "iPhone8,2":                               return "iPhone 6s Plus"
                case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
                case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
                case "iPhone8,4":                               return "iPhone SE"
                case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
                case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
                case "iPhone10,3", "iPhone10,6":                return "iPhone X"
                case "iPhone11,2":                              return "iPhone XS"
                case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
                case "iPhone11,8":                              return "iPhone XR"
                case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
                case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
                case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
                case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
                case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
                case "iPad6,11", "iPad6,12":                    return "iPad 5"
                case "iPad7,5", "iPad7,6":                      return "iPad 6"
                case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
                case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
                case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
                case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
                case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
                case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
                case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
                case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
                case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
                case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
                case "AppleTV5,3":                              return "Apple TV"
                case "AppleTV6,2":                              return "Apple TV 4K"
                case "AudioAccessory1,1":                       return "HomePod"
                case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
                default:                                        return identifier
                 }
                #elseif os(tvOS)
                switch identifier {
                case "AppleTV5,3": return "Apple TV 4"
                case "AppleTV6,2": return "Apple TV 4K"
                case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
                default: return identifier
                }
                #endif
            }
            return mapToDevice(identifier: identifier)
        }
    }
    
    struct BatteryInfo {
        
        init() {
            UIDevice.current.isBatteryMonitoringEnabled = true
        }
        
        // The battery state for the device. (unknown, unplugged, charging, full)
        var state: UIDevice.BatteryState {
            return UIDevice.current.batteryState
        }
        
        // The battery charge level for the device.
        // in range 0...1 -1 for simulators
        var level: Float {
            return UIDevice.current.batteryLevel
        }
    }
    
    struct CPUInfoModel {
        func getCPUName() -> String {
            let processorNames = Array(CPUinfo().keys)
            return processorNames[0]
        }
           
        public func getCPUSpeed() -> String {
            let processorSpeed = Array(CPUinfo().values)
            return processorSpeed[0]
        }

        private func CPUinfo() -> Dictionary<String, String> {
            #if targetEnvironment(simulator)
            let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
            #else

            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8 , value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            #endif
            
            switch identifier {
            case "iPod5,1":                                 return ["A5":"800 MHz"] // underclocked
            case "iPod7,1":                                 return ["A8":"1.4 GHz"]
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return ["A4":"800 MHz"] // underclocked
            case "iPhone4,1":                               return ["A5":"800 MHz"] // underclocked
            case "iPhone5,1", "iPhone5,2":                  return ["A6":"1.3 GHz"]
            case "iPhone5,3", "iPhone5,4":                  return ["A6":"1.3 GHz"]
            case "iPhone6,1", "iPhone6,2":                  return ["A7":"1.3 GHz"]
            case "iPhone7,2":                               return ["A8":"1.4 GHz"]
            case "iPhone7,1":                               return ["A8":"1.4 GHz"]
            case "iPhone8,1":                               return ["A9":"1.85 GHz"]
            case "iPhone8,2":                               return ["A9":"1.85 GHz"]
            case "iPhone9,1", "iPhone9,3":                  return ["A10 Fusion":"2.34 GHz"]
            case "iPhone9,2", "iPhone9,4":                  return ["A10 Fusion":"2.34 GHz"]
            case "iPhone8,4":                               return ["A9":"1.85 GHz"]
            case "iPhone10,1", "iPhone10,4":                return ["A11 Bionic":"2.39 GHz"]
            case "iPhone10,2", "iPhone10,5":                return ["A11 Bionic":"2.39 GHz"]
            case "iPhone10,3", "iPhone10,6":                return ["A11 Bionic":"2.39 GHz"]
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return ["A5":"1.0 GHz"]
            case "iPad3,1", "iPad3,2", "iPad3,3":           return ["A5X":"1.0 GHz"]
            case "iPad3,4", "iPad3,5", "iPad3,6":           return ["A6X":"1.4 GHz"]
            case "iPad4,1", "iPad4,2", "iPad4,3":           return ["A7":"1.4 GHz"]
            case "iPad5,3", "iPad5,4":                      return ["A8X":"1.5 GHz"]
            case "iPad6,11", "iPad6,12":                    return ["A9":"1.85 GHz"]
            case "iPad2,5", "iPad2,6", "iPad2,7":           return ["A5":"1.0 GHz"]
            case "iPad4,4", "iPad4,5", "iPad4,6":           return ["A7":"1.3 GHz"]
            case "iPad4,7", "iPad4,8", "iPad4,9":           return ["A7":"1.3 GHz"]
            case "iPad5,1", "iPad5,2":                      return ["A8":"1.5 GHz"]
            case "iPad6,3", "iPad6,4":                      return ["A9X":"2.16 GHz"] // underclocked
            case "iPad6,7", "iPad6,8":                      return ["A9X":"2.24 GHz"]
            case "iPad7,1", "iPad7,2":                      return ["A10X Fusion":"2.34 GHz"]
            case "iPad7,3", "iPad7,4":                      return ["A10X Fusion":"2.34 GHz"]
            case "AppleTV5,3":                              return ["A8":"1.4 GHz"]
            case "AppleTV6,2":                              return ["A10X Fusion":"2.34 GHz"]
            case "AudioAccessory1,1":                       return ["A8":"1.4 GHz"] // clock speed is a guess
            default:                                        return ["N/A":"N/A"]
            }
        }
    }
    
    struct ProcessInfoModel {
        
        // Global unique identifier for the process.
        var globallyUniqueString: String {
            return ProcessInfo.processInfo.globallyUniqueString
        }
        
        // The name of the host computer on which the process is executing.
        var hostName: String {
            return ProcessInfo.processInfo.hostName
        }
        
        // The home directory of your application (points to the root of your sandbox)
        var environmentHomePath: String {
            let environment = ProcessInfo.processInfo.environment
            let homePath = environment["HOME"]
            return homePath ?? ""
        }
        
        // The number of processing cores available on the computer.
        var processorCount: Int {
            let count = ProcessInfo.processInfo.processorCount
            return count
        }
    }
    
    struct CarrierInfoModel {
        private var carrier: CTCarrier? {
            return CTTelephonyNetworkInfo().subscriberCellularProvider
        }
        
        // the name of the subscriber's cellular service provider.
        var providerName: String? {
            return carrier?.carrierName
        }
        
        // the mobile country code for the subscriber's cellular service provider
        var mobileCountryCode: String? {
            return carrier?.mobileCountryCode
        }
        
        // the  mobile network code for the subscriber's cellular service provider
        var mobileNetworkCode: String? {
            return carrier?.mobileNetworkCode
        }
        
        // country code for the subscriber's cellular service provider
        var isoCountryCode: String? {
            return carrier?.isoCountryCode
        }
    }
    
    struct WifiInfoModel {
        struct Info {
            public let interface:String
            public let ssid:String
            public let bssid:String
            init(_ interface:String, _ ssid:String,_ bssid:String) {
                self.interface = interface
                self.ssid = ssid
                self.bssid = bssid
            }
        }
        
        var ssid: String? {
            return getWifiInfo().first?.ssid
        }
        
        // need turn on Access WiFi Information in capabilities
        private func getWifiInfo() -> Array<Info> {
            guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else {
                return []
            }
            let wifiInfo:[Info] = interfaceNames.compactMap{ name in
                guard let info = CNCopyCurrentNetworkInfo(name as CFString) as? [String:AnyObject] else {
                    return nil
                }
                guard let ssid = info[kCNNetworkInfoKeySSID as String] as? String else {
                    return nil
                }
                guard let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String else {
                    return nil
                }
                return Info(name, ssid,bssid)
            }
            return wifiInfo
        }
    }
    
    struct DiskSpaceInfo {
        
        func MBFormatter(_ bytes: Int64) -> String {
             let formatter = ByteCountFormatter()
             formatter.allowedUnits = ByteCountFormatter.Units.useMB
             formatter.countStyle = ByteCountFormatter.CountStyle.decimal
             formatter.includesUnit = false
             return formatter.string(fromByteCount: bytes) as String
         }

        var totalDiskSpaceInGB:String {
           return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
        }

        var freeDiskSpaceInGB:String {
            return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
        }

        var usedDiskSpaceInGB:String {
            return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
        }

        var totalDiskSpaceInMB:String {
            return MBFormatter(totalDiskSpaceInBytes)
        }

        var freeDiskSpaceInMB:String {
            return MBFormatter(freeDiskSpaceInBytes)
        }

        var usedDiskSpaceInMB:String {
            return MBFormatter(usedDiskSpaceInBytes)
        }
        
        var totalDiskSpaceInBytes:Int64 {
            guard let systemAttributes = try? FileManager.default
                .attributesOfFileSystem(forPath: NSHomeDirectory() as String),
                let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?
                    .int64Value else { return 0 }
            return space
        }
        
        var freeDiskSpaceInBytes:Int64 {
             if #available(iOS 11.0, *) {
                 if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
                     return space ?? 0
                 } else {
                     return 0
                 }
             } else {
                 if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
                 let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value {
                     return freeSpace
                 } else {
                     return 0
                 }
             }
         }
        
        var usedDiskSpaceInBytes:Int64 {
            return totalDiskSpaceInBytes - freeDiskSpaceInBytes
        }
    }
    
}
