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
        .configurationDisplayName("Grades")
        .description("See your grades.")
        .supportedFamilies([.systemLarge])
    }
}
