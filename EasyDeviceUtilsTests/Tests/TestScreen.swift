//
//  TestScreen.swift
//  EasyDeviceUtilsTests
//
//  Created by EugenKGD on 26/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import XCTest

class TestScreen: XCTestCase {

    func testScreen() {
        
        let screen = EasyDeviceUtils.shared.screen
        
        XCTAssertNotEqual(screen.isPortrait, screen.isLandscape)
        
        XCTAssertTrue(0 <= screen.brightness, "Brightness is incorrect")
        XCTAssertTrue(screen.brightness <= 1, "Brightness is incorrect")

    }

}
