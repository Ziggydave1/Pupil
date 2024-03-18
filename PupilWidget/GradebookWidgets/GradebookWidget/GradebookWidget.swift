//
//  GradebookWidget.swift
//  PupilWidgetExtension
//
//  Created by Evan Kaneshige on 3/26/23.
//

import WidgetKit
import SwiftUI
import SwiftData

struct GradebookWidget: Widget {
    let kind: String = "pupil.widgets.gradebook"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: GradebookWidgetProvider()) { entry in
            if let container {
                GradebookWidgetView(entry: entry)
                    .containerBackground(Color.init(.systemGray6), for: .widget)
                    .modelContainer(container)
            } else {
                GradebookWidgetView(entry: entry)
                    .containerBackground(Color.init(.systemGray6), for: .widget)
                    .modelContainer(for: [AliasLink.self, Alias.self])
            }
        }
        .configurationDisplayName(String(localized: "WIDGET_NAME_GRADES", defaultValue: "Grades", comment: "The name of the grades widget"))
        .description(String(localized: "WIDGET_DESC_GRADES", defaultValue: "See your grades.", comment: "Description of the grades widget"))
        .supportedFamilies([.systemLarge])
    }
    
    private var container: ModelContainer? {
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: App_Group) else { return nil }
        
        let storeURL = containerURL.appending(path: "PupilStorage.sqlite")
        let config = ModelConfiguration(url: storeURL)
        
        return try? ModelContainer(for: AliasLink.self, Alias.self, configurations: config)
    }
}
