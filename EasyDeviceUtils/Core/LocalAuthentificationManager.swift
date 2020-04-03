//
//  LocalAuthentificationManager.swift
//  DeviceUtils
//
//  Created by EugenKGD on 15/11/2019.
//  Copyright © 2019 ELezov. All rights reserved.
//

import Foundation
import LocalAuthentication

class LocalAuthentificationManager {
    
    func hasPasscode() -> Bool {
      //checks to see if devices (not apps) passcode has been set
      return LAContext().canEvaluatePolicy(.deviceOwnerAuthentication,
                                           error: nil)
    }
    
    func hasFingerprint() -> Bool {
        let context = LAContext()
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        // Получаем текущие биометрические данные
        return context.evaluatedPolicyDomainState != nil
    }
}
