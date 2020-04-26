//
//  ProcessInfoModel.swift
//  EasyDeviceUtils
//
//  Created by EugenKGD on 02/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import Foundation

public struct ProcessInfoModel {
    
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
