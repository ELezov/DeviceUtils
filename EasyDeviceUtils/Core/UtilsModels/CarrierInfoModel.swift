//
//  CarrierInfoModel.swift
//  EasyDeviceUtils
//
//  Created by EugenKGD on 02/04/2020.
//  Copyright © 2020 ELezov. All rights reserved.
//

import CoreTelephony

/// Модель для получении информации о провайдере
public struct CarrierInfoModel {
    
    private var carrier: CTCarrier? {
        return CTTelephonyNetworkInfo().subscriberCellularProvider
    }
    
    // the name of the subscriber's cellular service provider.
    public var providerName: String? {
        return carrier?.carrierName
    }
    
    // the mobile country code for the subscriber's cellular service provider
    public var mobileCountryCode: String? {
        return carrier?.mobileCountryCode
    }
    
    // the  mobile network code for the subscriber's cellular service provider
    public var mobileNetworkCode: String? {
        return carrier?.mobileNetworkCode
    }
    
    // country code for the subscriber's cellular service provider
    public var isoCountryCode: String? {
        return carrier?.isoCountryCode
    }
}
