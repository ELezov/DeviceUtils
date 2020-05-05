//
//  TestScreen.swift
//  EasyDeviceUtilsTests
//
//  Created by EugenKGD on 26/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import XCTest
import EasyDeviceUtils

class TestScreen: XCTestCase {

    func testScreen() {
        
        let screen = EasyDeviceUtils.screen
                
        XCTAssertTrue(0 <= screen.brightness, "Brightness is incorrect")
        XCTAssertTrue(screen.brightness <= 100, "Brightness is incorrect")

    }

}
