//
//  CourseConfiguration.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/16/24.
//

import Foundation
import AppIntents
import Defaults

struct CourseConfiguration: AppIntent, WidgetConfigurationIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "CourseConfigurationIntent"

    static var title: LocalizedStringResource = "Course Configuration"
    static var description = IntentDescription("")

    @Parameter(title: "Course Name", optionsProvider: StringOptionsProvider())
    var courseName: String?

    struct StringOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            guard Defaults[.useBiometrics] else {
                return []
            }
            
            return Defaults[.courseList]
        }
    }

    static var parameterSummary: some ParameterSummary {
        Summary()
    }
}


