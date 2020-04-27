//
//  UIDevice+Idiom.swift
//  EasyDeviceUtils
//
//  Created by EugenKGD on 26/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    class var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }
    
    class var isCarPlay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
    
}
