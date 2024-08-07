//
//  GradebookWidgetView.swift
//  PupilWidgetExtension
//
//  Created by Evan Kaneshige on 3/26/23.
//

import SwiftUI
import SwiftVue
import WidgetKit
import Defaults

struct GradebookWidgetView: View {
    @Environment(\.widgetFamily) var family
    var entry: GradebookWidgetEntry
    
    var body: some View {
        ZStack {
            Color.init(.systemGray6)
            if let error = entry.error {
                Text(error)
                    .padding()
            } else {
                if let grades = entry.grades {
                    switch family {
                    case .systemLarge:
                        GradebookWidgetLarge(grades: grades)
                    default:
                        Text(String(localized: "WIDGET_SIZE_NOT_IMPLEMENTED", defaultValue: "Not Implemented", comment: "The selected widget size is not supported"))
                    }
                } else {
                    Text(String(localized: "WIDGET_NO_GRADE_DATA", defaultValue: "No Grade Data", comment: "The current widget entry has no gradebook data"))
                }
            }
        }
    }
}

struct GradebookWidgetLarge: View {
    @Default(.gradeColors) var gradeColors
    let grades: Gradebook
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text(grades.reportingPeriod.name)
                    .font(.headline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            ForEach(grades.courses.prefix(7)) { course in
                let alias = PersistenceController.shared.alias(for: course.title)
                HStack {
                    Image(systemName: alias?.icon ?? "studentdesk")
                        .frame(minWidth: 30)
                    Text(alias?.name ?? course.title)
                        .lineLimit(1)
                    Spacer()
                    if let mark = course.marks.first {
                        Text(mark.scoreString)
                            .font(.title2)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(gradeColors.color(for: mark.scoreRaw, and: mark.scoreString))
                            .frame(minWidth: 45, alignment: .leading)
                    }
                }
                .font(.title3)
                .fontWeight(.medium)
            }
            if grades.courses.count < 7 {
                Spacer()
            }
        }
        .padding()
    }
    
    func formatGrade(_ input: String) -> String {
        let components = input.components(separatedBy: "/")
        if let numerator = Double(components[0].trimmingCharacters(in: .whitespacesAndNewlines)) {
            if let denominator = Double(components[1].trimmingCharacters(in: .whitespacesAndNewlines)) {
                return String(format: "%g/%g", numerator, denominator)
            }
        }
        return String(localized: "WIDGET_GRADES_NA", defaultValue: "N/A", comment: "Unable to parse the grades")
    }
}
