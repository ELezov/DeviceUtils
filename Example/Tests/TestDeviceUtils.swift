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
        XCTAssertTrue(EasyDeviceUtils.appIdentifier != nil, "appIdentifier is nil")
        XCTAssertTrue(EasyDeviceUtils.uniqueIdentifier != nil, "uniqueIdentifier is nil")
    }
    
    func testGMTOffset() {
        
        XCTAssertTrue(EasyDeviceUtils.GMToffset < 24, "GMTOffset is incorrect")
    }
}
