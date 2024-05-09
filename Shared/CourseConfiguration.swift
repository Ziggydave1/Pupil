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

    static let title = LocalizedStringResource("COURSE_WIDGET_CONFIG_INTENT_TITLE", defaultValue: "Course Configuration", comment: "The title of the widget configuration app intent")
    static let description = IntentDescription(LocalizedStringResource("COURSE_WIDGET_CONFIG_INTENT_DESC", defaultValue: "Configure widget to display a selected course", comment: "The description of the widget configuration app intent"))

    @Parameter(title: LocalizedStringResource("COURSE_WIDGET_CONFIG_NAME_PARAM", defaultValue: "Course Name", comment: "The course name parameter for the widget configuration app intent"), optionsProvider: StringOptionsProvider())
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

extension IntentDescription: @unchecked Sendable { }

