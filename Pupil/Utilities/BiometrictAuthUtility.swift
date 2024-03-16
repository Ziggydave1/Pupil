//
//  BiometrictAuthUtility.swift
//  Pupil
//
//  Created by Evan Kaneshige on 11/29/23.
//

import Foundation
import Combine
import LocalAuthentication

class BiometricAuthUtlity {
    static let shared = BiometricAuthUtlity()
    
    private init() { }
    
    public func authenticate() -> Future<Bool, Error> {
        Future { promise in
            
            func handleReply(success: Bool, error: Error?) -> Void {
                if error == nil {
                    return promise(.success(success))
                } else {
                    return promise(.failure(LAError(.authenticationFailed)))
                }
            }
            
            let context = LAContext()
            var error: NSError?
            let reason = String(localized: "BIOMETRIC_AUTH_REASON", defaultValue: "Authorization is required to unlock data", comment: "The reason given when asking the user to authenticate biometricly")
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply: handleReply)
            } else {
                promise(.failure(LAError(.authenticationFailed)))
            }
        }
    }
    
    
}
