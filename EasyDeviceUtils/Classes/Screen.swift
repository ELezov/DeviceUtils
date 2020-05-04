//
//  Screen.swift
//  EasyDeviceUtils
//
//  Created by EugenKGD on 02/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import UIKit

public struct Screen {
    
    public var scale: Scale {
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
    public var isRetina: Bool {
        return scale > Scale.x1
    }
    
    public var brightness: Int {
        return Int(UIScreen.main.brightness * 100)
    }
    
    public var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
    public var orientation: Orientation {
        return isLandscape ? .landscape : .portrait
    }
    
    public var diagonal: Diagonal {
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
            if EasyDeviceUtils.shared.modelInfo.isIpadMini {
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

public extension Screen {
    
    enum Orientation {
        case landscape
        case portrait
    }
    
    enum ScreenFamily: String {
        case unknown = "unknown"
        case old     = "old"
        case small   = "small"
        case medium  = "medium"
        case big     = "big"
    }
    
    enum Diagonal: CGFloat {
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
        var family: ScreenFamily {
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
}

fileprivate extension Screen {
    /// Return `true` for landscape interface orientation
    var isLandscape: Bool {
        return ( UIApplication.shared.statusBarOrientation == .landscapeLeft
             || UIApplication.shared.statusBarOrientation == .landscapeRight )
    }
}
