//
//  AppDelegate.swift
//  FraudResearch
//
//  Created by EugenKGD on 12/11/2019.
//  Copyright © 2019 ELezov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(DeviceUtils.shared.GMToffset)
        print(DeviceUtils.shared.localeCode)
        print(DeviceUtils.shared.uniqueIdentifier)
        print("----")
        print(DeviceUtils.shared.carrierInfoModel.providerName)
        print(DeviceUtils.shared.batteryInfo.state.rawValue)
        print(DeviceUtils.shared.batteryInfo.level)
        print(DeviceUtils.shared.isSimulator)
        print(UIDevice.current.model)
        for (key, value) in ProcessInfo.processInfo.environment {
            print("\(key): \(value)")
        }
        print(DeviceUtils.shared.processInfoModel.environmentHomePath)
        print(DeviceUtils.shared.cpuInfoModel.getCPUName())
        print(DeviceUtils.shared.cpuInfoModel.getCPUSpeed())
        print(DeviceUtils.shared.processInfoModel.hostName)
        print(DeviceUtils.shared.processInfoModel.globallyUniqueString)
        print(DeviceUtils.shared.wifiInfoModel.ssid)
        print(DeviceUtils.shared.processInfoModel.processorCount)
        print(DeviceUtils.shared.diskSpaceInfo.totalDiskSpaceInGB)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(windowTap))
        window?.addGestureRecognizer(tap)
        
        print(LocalAuthentificationManager().hasPasscode())
        print(LocalAuthentificationManager().hasFingerprint())
        return true
    }
    
    @objc func windowTap() {
        print("window tap")
    }

}

