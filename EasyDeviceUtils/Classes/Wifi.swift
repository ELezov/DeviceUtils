//
//  WifiInfoModel.swift
//  EasyDeviceUtils
//
//  Created by EugenKGD on 02/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import SystemConfiguration.CaptiveNetwork

/// Модель для получения информации о подключенном wifi
public struct Wifi {
    
    public struct Info {
        
        public let interface:String
        
        public let ssid:String
        
        public let bssid:String
        
        init(_ interface:String,
             _ ssid:String,
             _ bssid:String) {
            self.interface = interface
            self.ssid = ssid
            self.bssid = bssid
        }
    }
    
    public var ssid: String? {
        return getWifiInfo().first?.ssid
    }
    
    // need turn on Access WiFi Information in capabilities
    private func getWifiInfo() -> Array<Info> {
        guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else {
            return []
        }
        let wifiInfo: [Info] = interfaceNames.compactMap { name in
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
