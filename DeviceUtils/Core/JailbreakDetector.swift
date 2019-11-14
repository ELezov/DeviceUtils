//
//  JailbreakDetector.swift
//  FraudResearch
//
//  Created by EugenKGD on 13/11/2019.
//  Copyright © 2019 ELezov. All rights reserved.
//

import UIKit

class JailbreakDetector {
    
    var isJailbroken: Bool {
        
        #if targetEnvironment(simulator)
        return false
        #else
        
        if
            canOpen(path: "/Applications/Cydia.app") ||
            canOpen(path: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            canOpen(path: "/bin/bash") ||
            canOpen(path: "/usr/sbin/sshd") ||
            canOpen(path: "/etc/apt") ||
            canOpen(path: "/usr/bin/ssh") {
            return true
        }
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
            fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            fileManager.fileExists(atPath: "/bin/bash") ||
            fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
            fileManager.fileExists(atPath: "/etc/apt") ||
            fileManager.fileExists(atPath: "/usr/bin/ssh") {
            return true
        }
        
        // Check if the app can access outside of its sandbox
        do {
            try ".".write(toFile: "/private/jailbreak.txt",
                          atomically: true,
                          encoding: .utf8)
            try fileManager.removeItem(atPath: "/private/jailbreak.txt")
            return true
        } catch {
            // do nothing
        }
        
        // Check if the app can open a Cydia's URL scheme
        if
            let url = URL(string: "cydia://package/com.example.package"),
            UIApplication.shared.canOpenURL(url) {
            return true
        }
        return false
        #endif
    }
}

fileprivate extension JailbreakDetector {
    func canOpen(path: String) -> Bool {
        let file = fopen(path, "r")
        guard let existFile = file else { return false }
        fclose(existFile)
        return true
    }
}
