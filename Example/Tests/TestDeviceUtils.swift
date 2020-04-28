//
//  TestDeviceUtils.swift
//  EasyDeviceUtilsTests
//
//  Created by EugenKGD on 26/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import XCTest
import EasyDeviceUtils

class TestDeviceUtils: XCTestCase {

    func testIdentifier() {
        let deviceUtils = EasyDeviceUtils.shared
        
        XCTAssertTrue(deviceUtils.appIdentifier != nil, "appIdentifier is nil")
        XCTAssertTrue(deviceUtils.uniqueIdentifier != nil, "uniqueIdentifier is nil")
    }
    
    func testGMTOffset() {
        let deviceUtils = EasyDeviceUtils.shared
        
        XCTAssertTrue(deviceUtils.GMToffset < 24, "GMTOffset is incorrect")
    }
}
