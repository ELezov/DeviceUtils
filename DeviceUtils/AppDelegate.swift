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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(FraudHelper().GMToffset)
        print(FraudHelper().localeCode)
        print(FraudHelper().uniqueIdentifier)
        print("----")
        print(FraudHelper().carrierInfoModel.providerName)
        print(FraudHelper().batteryInfo.state.rawValue)
        print(FraudHelper().batteryInfo.level)
        print(FraudHelper().isSimulator)
        print(UIDevice.current.model)
        for (key, value) in ProcessInfo.processInfo.environment {
            print("\(key): \(value)")
        }
        print(FraudHelper().processInfoModel.environmentHomePath)
        print(FraudHelper().cpuInfoModel.getCPUName())
        print(FraudHelper().cpuInfoModel.getCPUSpeed())
        print(FraudHelper().processInfoModel.hostName)
        print(FraudHelper().processInfoModel.globallyUniqueString)
        print(FraudHelper().wifiInfoModel.ssid)
        print(FraudHelper().processInfoModel.processorCount)
        print(FraudHelper().diskSpaceInfo.totalDiskSpaceInGB)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

