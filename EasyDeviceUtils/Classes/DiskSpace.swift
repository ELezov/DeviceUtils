//
//  DiskSpaceModel.swift
//  EasyDeviceUtils
//
//  Created by EugenKGD on 02/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import Foundation

/// Модель для получении информации о дисковом пространстве устройства
public struct DiskSpace {
    
    public struct Space {
        public var inBytes: Int64
        
        public var inGb: String {
            return ByteCountFormatter.string(fromByteCount: inBytes,
                                             countStyle: ByteCountFormatter.CountStyle.decimal)
        }
        
        public var inMb: String {
            return MBFormatter(inBytes)
        }
        
        public init(bytes: Int64) {
            self.inBytes = bytes
        }
        
        private func MBFormatter(_ bytes: Int64) -> String {
            let formatter = ByteCountFormatter()
            formatter.allowedUnits = ByteCountFormatter.Units.useMB
            formatter.countStyle = ByteCountFormatter.CountStyle.decimal
            formatter.includesUnit = false
            return formatter.string(fromByteCount: bytes) as String
        }
    }
    
    /// Общее место
    public var total: Space {
        return Space(bytes: totalDiskSpaceInBytes)
    }
    
    /// Свободное место
    public var free: Space {
        return Space(bytes: freeDiskSpaceInBytes)
    }
    
    /// Использованное место
    public var used: Space {
        return Space(bytes: usedDiskSpaceInBytes)
    }
}

fileprivate extension DiskSpace {
    
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
    
}
