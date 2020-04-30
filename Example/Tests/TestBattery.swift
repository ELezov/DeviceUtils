//
//  TestBattery.swift
//  EasyDeviceUtilsTests
//
//  Created by EugenKGD on 26/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import XCTest
import EasyDeviceUtils

class TestBattery: XCTestCase {

    func testBatteryLevel() {
        let batteryValue = EasyDeviceUtils.shared.batteryInfo.batteryLevel

        #if targetEnvironment(simulator)
            XCTAssertEqual(batteryValue, 100)
        #else
            XCTAssertTrue(0<=batteryValue<=1, "battery level is incorrect")
        #endif
    }
    
    func testBatteryState() {
        let batteryState = EasyDeviceUtils.shared.batteryInfo.state
        #if targetEnvironment(simulator)
        XCTAssertEqual(batteryState, b.State.simulator)
        #endif
    }

}
