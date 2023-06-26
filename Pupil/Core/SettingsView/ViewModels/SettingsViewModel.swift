//
//  SettingsViewModel.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/27/23.
//

import Foundation
import LocalAuthentication
import Defaults
import SwiftVue
import Combine
import WidgetKit
import KeychainAccess

class SettingsViewModel: ObservableObject {
    let credentials: Credentials
    let useBiometricsObserver: AnyCancellable?
    
    init(credentials: Credentials) {
        self.credentials = credentials
        
        useBiometricsObserver = Defaults.publisher(.useBiometrics)
            .sink(receiveValue: { value in
                if value.newValue {
                    let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)
                    Defaults[.username] = credentials.username
                    keychain["password"] = credentials.password
                }
                WidgetCenter.shared.reloadAllTimelines()
            })
    }
    
    func getBiometricType() -> String? {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            switch context.biometryType {
            case .faceID: return "Face ID"
            case .touchID: return "Touch ID"
            case .none: return nil
            @unknown default: return nil
            }
        }
        return nil
    }
}
