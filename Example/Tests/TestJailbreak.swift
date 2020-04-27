//
//  TestJailbreak.swift
//  EasyDeviceUtilsTests
//
//  Created by EugenKGD on 26/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import XCTest

class TestJailbreak: XCTestCase {

    func testSimilatorJailbreak() {
        let isSimulator = EasyDeviceUtils.isSimulator
        
        let isJailbroken = JailbreakDetector.isJailbroken
        
        #if targetEnvironment(simulator)
        XCTAssertEqual(isSimulator, true)
        #endif
        
        if isSimulator {
            XCTAssertEqual(isSimulator, isJailbroken)
        }
    }

}
