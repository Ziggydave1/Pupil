//
//  CourseWidgetView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/26/23.
//

import SwiftUI
import SwiftVue
import WidgetKit
import Defaults

struct CourseWidgetView : View {
    @Environment(\.widgetFamily) var family
    @Environment(\.colorScheme) var colorScheme
    var entry: CourseWidgetEntry
    
    var body: some View {
        ZStack {
            Color.init(.systemGray6)
            if let error = entry.error {
                Text(error)
                    .padding()
            } else {
                if let course = entry.course, let mark = course.marks.first {
                    let alias = PersistenceController.shared.alias(for: course.title)
                    let courseName = alias?.name ?? course.title
                    let courseIcon = alias?.icon ?? "studentdesk"
                    switch family {
                    case .systemSmall:
                        CourseWidgetSmall(mark: mark, courseName: courseName)
                    case .systemMedium:
                        CourseWidgetMedium(mark: mark, courseName: courseName, courseIcon: courseIcon)
                    default:
                        Text("Not Implemented")
                    }
                } else {
                    Text("No Grade Data")
                }
            }
        }
    }
}

struct CourseWidget_Previews: PreviewProvider {
    static var previews: some View {
        CourseWidgetView(entry: CourseWidgetEntry(date: Date(), configuration: CourseConfigurationIntent(), course: dev.multiMarkCourse, error: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

struct CourseWidgetSmall: View {
    @Default(.gradeColors) var gradeColors
    let mark: Mark
    let courseName: String
    var body: some View {
        VStack {
            ZStack {
                if mark.scoreString == "N/A" {
                    CircularProgressView(progress: 100, lineWidth: 8, color: .gray)
                    Text("N/A")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                } else {
                    CircularProgressView(progress: Double(mark.scoreRaw) ?? 0, lineWidth: 8, color: gradeColors.color(for: mark.scoreRaw, and: mark.scoreString))
                    
                    VStack(spacing: -6) {
                        Text(mark.scoreString)
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        Text("\(mark.scoreRaw)%")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Text(courseName)
                .font(.headline)
                .lineLimit(1)
        }
        .padding()
    }
}

struct CourseWidgetMedium: View {
    @Default(.gradeColors) var gradeColors
    let mark: Mark
    let courseName: String
    let courseIcon: String
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Group {
                    Image(systemName: courseIcon)
                    Text(courseName)
                }
                .font(.title3.weight(.semibold))
                .lineLimit(1)
                
                Spacer()
                Text(mark.scoreString)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(gradeColors.color(for: mark.scoreRaw, and: mark.scoreString))
            }
            
            Divider()
            
            ForEach(mark.assignments.prefix(4)) { assignment in
                HStack {
                    Text(assignment.name)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                    Text(formatGrade(assignment.points))
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
            if mark.assignments.count < 4 {
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
        return "N/A"
    }
}
