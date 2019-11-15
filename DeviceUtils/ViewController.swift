//
//  ViewController.swift
//  FraudResearch
//
//  Created by EugenKGD on 12/11/2019.
//  Copyright © 2019 ELezov. All rights reserved.
//

import UIKit
import CoreMotion
import WebKit

class ViewController: UIViewController {
    
    var motionManager: CMMotionManager!
    
    @IBOutlet weak var webView: WKWebView!
    @IBAction func didTapButton(_ sender: Any) {
        print("Button tap")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.isHidden = true
        
        func loadHtmlFile() {
            if let url = Bundle.main.url(forResource: "motion",
                                         withExtension: "html") {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
        
        loadHtmlFile()
        if let url = URL(string: "https://www.google.com/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
//        motionManager = CMMotionManager()
//        motionManager.accelerometerUpdateInterval = 3
//        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
//            guard let info = data else { return }
//            print("Accelerometer",
//                  info.acceleration.x,
//                  info.acceleration.y,
//                  info.acceleration.z)
//        }
//
//        motionManager.magnetometerUpdateInterval = 3
//        motionManager.startMagnetometerUpdates(to: OperationQueue.main) { (data, error) in
//            guard let info = data else { return }
//            print("Magnetometer",
//                  info.magneticField.x,
//                  info.magneticField.y,
//                  info.magneticField.z)
//        }
//
//        motionManager.gyroUpdateInterval = 3
//        motionManager.startGyroUpdates(to: OperationQueue.main) { (data, error) in
//            guard let info = data else { return }
//            print("Gyroscope",
//                  info.rotationRate.x,
//                  info.rotationRate.y,
//                  info.rotationRate.z)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.getHTML()
        }
    }
    
    func getHTML() {
        webView.evaluateJavaScript("document.documentElement.innerHTML",
                                   completionHandler: { (html: Any?, error: Error?) in
            print(html)
        })
    }
}
