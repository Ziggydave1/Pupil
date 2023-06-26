//
//  CourseWidget.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/26/23.
//

import WidgetKit
import SwiftUI
import Intents

struct CourseWidget: Widget {
    let kind: String = "pupil.widgets.gradebook.course"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: CourseConfigurationIntent.self, provider: CourseWidgetProvider()) { entry in
            CourseWidgetView(entry: entry)
        }
        .configurationDisplayName("Class Grades")
        .description("See your grades in a class.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
