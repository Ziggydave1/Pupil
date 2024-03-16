//
//  GradebookWidget.swift
//  PupilWidgetExtension
//
//  Created by Evan Kaneshige on 3/26/23.
//

import WidgetKit
import SwiftUI
import Intents

struct GradebookWidget: Widget {
    let kind: String = "pupil.widgets.gradebook"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: GradebookWidgetProvider()) { entry in
            GradebookWidgetView(entry: entry)
        }
        .configurationDisplayName(String(localized: "WIDGET_NAME_GRADES", defaultValue: "Grades", comment: "The name of the grades widget"))
        .description(String(localized: "WIDGET_DESC_GRADES", defaultValue: "See your grades.", comment: "Description of the grades widget"))
        .supportedFamilies([.systemLarge])
    }
}
