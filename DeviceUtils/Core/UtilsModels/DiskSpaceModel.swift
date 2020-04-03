//
//  DiskSpaceModel.swift
//  DeviceUtils
//
//  Created by EugenKGD on 02/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import Foundation

/// Модель для получении информации о дисковом пространстве устройства
public struct DiskSpaceModel {
    
    /// Общее место в гб
    public var totalDiskSpaceInGB: String {
        return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    /// Свободное место в гб
    public var freeDiskSpaceInGB: String {
        return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    /// Использованное место в гб
    public var usedDiskSpaceInGB: String {
        return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    /// Общее место в мб
    public var totalDiskSpaceInMB: String {
        return MBFormatter(totalDiskSpaceInBytes)
    }
    
    /// Свободное место в мб
    public var freeDiskSpaceInMB: String {
        return MBFormatter(freeDiskSpaceInBytes)
    }
    
    /// Свободное место в мб
    public var usedDiskSpaceInMB: String {
        return MBFormatter(usedDiskSpaceInBytes)
    }
}

fileprivate extension DiskSpaceModel {
    
    var totalDiskSpaceInBytes: Int64 {
        guard let systemAttributes = try? FileManager.default
            .attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?
                .int64Value else { return 0 }
        return space
    }
    
    var freeDiskSpaceInBytes: Int64 {
        if #available(iOS 11.0, *) {
            if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
                return space
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
    
    var usedDiskSpaceInBytes: Int64 {
        return totalDiskSpaceInBytes - freeDiskSpaceInBytes
    }

    
    func MBFormatter(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes) as String
    }
    
}
