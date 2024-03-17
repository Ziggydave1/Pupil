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
        AppIntentConfiguration(kind: kind, intent: CourseConfiguration.self, provider: CourseWidgetProvider()) { entry in
            CourseWidgetView(entry: entry)
                .containerBackground(Color.init(.systemGray6), for: .widget)
        }
        .configurationDisplayName(String(localized: "WIDGET_NAME_CLASS_GRADES", defaultValue: "Class Grades", comment: "The name of the class grades widget"))
        .description(String(localized: "WIDGET_DESC_CLASS_GRADES", defaultValue: "See your grades in a single class.", comment: "The description of the class grades widget"))
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
