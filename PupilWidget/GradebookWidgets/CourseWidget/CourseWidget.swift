//
//  CourseWidget.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/26/23.
//

import WidgetKit
import SwiftUI
import SwiftData

struct CourseWidget: Widget {
    let kind: String = "pupil.widgets.gradebook.course"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: CourseConfiguration.self, provider: CourseWidgetProvider()) { entry in
            if let container {
                CourseWidgetView(entry: entry)
                    .containerBackground(Color.init(.systemGray6), for: .widget)
                    .modelContainer(container)
            } else {
                CourseWidgetView(entry: entry)
                    .containerBackground(Color.init(.systemGray6), for: .widget)
                    .modelContainer(for: [AliasLink.self, Alias.self])
            }
        }
        .configurationDisplayName(String(localized: "WIDGET_NAME_CLASS_GRADES", defaultValue: "Class Grades", comment: "The name of the class grades widget"))
        .description(String(localized: "WIDGET_DESC_CLASS_GRADES", defaultValue: "See your grades in a single class.", comment: "The description of the class grades widget"))
        .supportedFamilies([.systemSmall, .systemMedium])
    }
    
    private var container: ModelContainer? {
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: App_Group) else { return nil }
        
        let storeURL = containerURL.appending(path: "PupilStorage.sqlite")
        let config = ModelConfiguration(url: storeURL)
        
        return try? ModelContainer(for: AliasLink.self, Alias.self, configurations: config)
    }
}
