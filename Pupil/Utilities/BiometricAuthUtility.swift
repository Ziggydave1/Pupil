//
//  BiometricAuthUtility.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/1/23.
//

import Foundation
import Combine
import LocalAuthentication

struct BiometericAuthError: LocalizedError {
    
    var description: String
    
    init(description: String){
        self.description = description
    }
    
    init(error: Error){
        self.description = error.localizedDescription
    }
    
    var errorDescription: String?{
        return description
    }
}

class BiometricAuthUtlity {
    
    
    static let shared = BiometricAuthUtlity()
    
    private init() { }
    
    public func authenticate() -> Future<Bool, BiometericAuthError> {
        Future { promise in
            
            func handleReply(success: Bool, error: Error?) -> Void {
                if let error = error {
                    return promise(
                        .failure(BiometericAuthError(error: error))
                    )
                }
                
                promise(.success(success))
            }
            
            let context = LAContext()
            var error: NSError?
            let reason = "Please authenticate yourself"
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: handleReply)
            } else if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                // fallback
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply: handleReply)
            }else{
                //cannot evaluate
                let error = BiometericAuthError(description: "Something went wrong while authenticating. Please try again")
                promise(.failure(error))
            }
        }
    }
    
    
}
