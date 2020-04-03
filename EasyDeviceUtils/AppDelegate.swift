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

