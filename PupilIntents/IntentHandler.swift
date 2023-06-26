//
//  IntentHandler.swift
//  PupilIntents
//
//  Created by Evan Kaneshige on 3/26/23.
//

import Intents
import SwiftVue
import Defaults
import KeychainAccess

class IntentHandler: INExtension {
    
}

extension IntentHandler: CourseConfigurationIntentHandling {
    func provideCourseNameOptionsCollection(for intent: CourseConfigurationIntent) async throws -> INObjectCollection<NSString> {
        guard Defaults[.useBiometrics] else {
            return INObjectCollection(items: [])
        }
        
        let courses = Defaults[.courseList].map({ NSString(string: $0) })
        
        return INObjectCollection(items: courses)
    }
}
