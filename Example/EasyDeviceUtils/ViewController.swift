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
        deviceInfo["App Identifier"] = EasyDeviceUtils.appIdentifier ?? ""
        deviceInfo["Locale code"] = EasyDeviceUtils.localeCode ?? ""
        deviceInfo["Battery level"] = "\(EasyDeviceUtils.battery.state.level)"
        deviceInfo["Battery state"] = EasyDeviceUtils.battery.state.description
        deviceInfo["User device name"] = EasyDeviceUtils.userDeviceName
        deviceInfo["Model device name"] = EasyDeviceUtils.model.fullName
        deviceInfo["Model name"] = EasyDeviceUtils.model.name
        deviceInfo["Mobile country code"] = EasyDeviceUtils.carrier.mobileCountryCode
        deviceInfo["Mobile provider name"] = EasyDeviceUtils.carrier.providerName
        deviceInfo["Device screen brightness"] = "\(EasyDeviceUtils.screen.brightness)"
        deviceInfo["Device wifi ssid"] = EasyDeviceUtils.wifi.ssid

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

