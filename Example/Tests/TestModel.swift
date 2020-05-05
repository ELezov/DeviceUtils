//
//  TestModel.swift
//  EasyDeviceUtilsTests
//
//  Created by EugenKGD on 26/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import XCTest
import EasyDeviceUtils

class TestModel: XCTestCase {

    func testModel() {
        
        if EasyDeviceUtils.model.isIpadMini {
            XCTAssertTrue(UIDevice.isPad, "isIpadMini definitions is wrong")
        }
    }

}
