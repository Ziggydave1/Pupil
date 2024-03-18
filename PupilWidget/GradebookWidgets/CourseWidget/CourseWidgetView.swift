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
import SwiftData

struct CourseWidgetView: View {
    @Query private var aliasLinks: [AliasLink]
    @Environment(\.widgetFamily) var family
    @Environment(\.colorScheme) var colorScheme
    var entry: CourseWidgetEntry
    
    var body: some View {
        switch entry.result {
        case .success(let course):
            if let mark = course.marks.first {
                let alias = aliasLinks.first(where: { $0.key == course.title })?.value
                let courseName = alias?.name ?? course.title
                let courseIcon = alias?.icon ?? "studentdesk"
                switch family {
                case .systemSmall:
                    CourseWidgetSmall(mark: mark, courseName: courseName)
                case .systemMedium:
                    CourseWidgetMedium(mark: mark, courseName: courseName, courseIcon: courseIcon)
                default:
                    Text(String(localized: "WIDGET_SIZE_NOT_IMPLEMENTED", defaultValue: "Not Implemented"))
                }
            } else {
                Text(String(localized: "WIDGET_NO_GRADE_DATA", defaultValue: "No Grade Data", comment: "The current widget entry has no gradebook data"))
            }
        case .failure(let error):
            if let error = error as? PupilWidgetError {
                Text(error.errorDescription)
            } else {
                Text(error.localizedDescription)
            }
        }
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
                    Text(String(localized: "WIDGET_GRADES_NA_FOUND", defaultValue: "N/A", comment: "Course grade is N/A"))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundColor(.primary)
                } else {
                    CircularProgressView(progress: mark.scoreRaw, lineWidth: 8, color: gradeColors.color(for: mark.scoreRaw, and: mark.scoreString))
                    
                    VStack(spacing: -6) {
                        Text(mark.scoreString)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(.primary)
                        Text(mark.scoreRaw.rawScoreFormatted())
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Text(courseName)
                .font(.headline)
                .lineLimit(1)
        }
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
                .font(.title3)
                .fontWeight(.semibold)
                .lineLimit(1)
                
                Spacer()
                Text(mark.scoreString)
                    .font(.title3)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
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
    }
    
    func formatGrade(_ input: String) -> String {
        let components = input.components(separatedBy: "/")
        if let numerator = Double(components[0].trimmingCharacters(in: .whitespacesAndNewlines)) {
            if let denominator = Double(components[1].trimmingCharacters(in: .whitespacesAndNewlines)) {
                return String(format: "%g/%g", numerator, denominator)
            }
        }
        return String(localized: "WIDGET_GRADES_NA", defaultValue: "N/A")
    }
}
