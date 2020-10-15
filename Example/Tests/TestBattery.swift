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
        let batteryValue = EasyDeviceUtils.battery.state.level

        #if targetEnvironment(simulator)
            XCTAssertEqual(batteryValue, 100)
        #else
            //XCTAssertTrue(0 <= batteryValue <=100, "battery level is incorrect")
        #endif
    }
    
    func testBatteryState() {
        let batteryState = EasyDeviceUtils.battery.state
        #if targetEnvironment(simulator)
        XCTAssertEqual(batteryState, Battery.State.simulator)
        #endif
    }

}
