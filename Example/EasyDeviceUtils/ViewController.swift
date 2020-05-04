//
//  ViewController.swift
//  EasyDeviceUtils
//
//  Created by ELezov on 04/27/2020.
//  Copyright (c) 2020 ELezov. All rights reserved.
//

import UIKit
import EasyDeviceUtils

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var strings: [String] = []
    
    var deviceInfo: [String: String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        let device = EasyDeviceUtils.shared
        deviceInfo["App Identifier"] = device.appIdentifier ?? ""
        deviceInfo["Locale code"] = device.localeCode ?? ""
        deviceInfo["Battery level"] = "\(EasyDeviceUtils.battery.state.level)"
        deviceInfo["Battery state"] = EasyDeviceUtils.battery.state.description
        deviceInfo["User device name"] = device.userDeviceName
        deviceInfo["Model device name"] = device.modelInfo.modelDevice
        deviceInfo["Model name"] = device.modelInfo.modelString
        deviceInfo["Mobile country code"] = device.carrierInfo.mobileCountryCode
        deviceInfo["Mobile provider name"] = device.carrierInfo.providerName
        deviceInfo["Device screen brightness"] = "\(EasyDeviceUtils.screen.brightness)"
        deviceInfo["Device wifi ssid"] = device.wifiInfo.ssid

        strings = deviceInfo.map { "\($0.key): \($0.value)" }
        tableView.dataSource = self
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        
        cell?.textLabel?.text = strings[indexPath.row]
        cell?.textLabel?.font = UIFont.italicSystemFont(ofSize: 12)
        return cell ?? UITableViewCell()
    }
}

