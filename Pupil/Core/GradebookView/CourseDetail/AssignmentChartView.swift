//
//  AssignmentChartView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 10/30/23.
//

import SwiftUI
import SwiftVue
import Charts
import Defaults

struct AssignmentChartView: View {
    @Default(.gradeColors) var gradeColors
    var assignments: [Assignment]
    var body: some View {
        let chartData = assignments
            .filter { $0.score != "Not Graded" }
            .prefix(20)
        VStack(alignment: .leading) {
            Text(String(localized: "ASSIGNMENT_GRAPH_TITLE", defaultValue: "Recent Assignment Grades", comment: "Label for the title of the graph"))
                .foregroundStyle(.secondary)
            Text(String(localized: "ASSIGNMENT_GRAPH_COUNT", defaultValue: "Last \(chartData.count) Assignments", comment: "The count for the recent assignments shown on the graph"))
                .font(.title2)
                .fontWeight(.bold)
            Chart(Array(chartData.enumerated()), id: \.offset) { index, element in
                LineMark(
                    x: .value(String(localized: "ASSIGNMENT_GRAPH_X", defaultValue: "Index", comment: "The index of the assignment"), index..<(index + 1)),
                    y: .value(String(localized: "ASSIGNMENT_GRAPH_Y", defaultValue: "Score", comment: "The score of the assignment"), element.points.pointsToPercentage() / 100)
                )
                .foregroundStyle(gradeColors.defaultColor.opacity(0.5))
                .interpolationMethod(.catmullRom)
                
                PointMark(
                    x: .value(String(localized: "ASSIGNMENT_GRAPH_X", defaultValue: "Index"), index..<(index + 1)),
                    y: .value(String(localized: "ASSIGNMENT_GRAPH_Y", defaultValue: "Score"), element.points.pointsToPercentage() / 100)
                )
                .foregroundStyle(gradeColors.color(for: element.points.pointsToPercentage(), and: nil))
            }
            .chartXAxis(.hidden)
            .chartXScale(domain: [20, 0])
            .chartYAxis {
                AxisMarks(format: Decimal.FormatStyle.Percent.percent, values: .stride(by: 0.2))
            }
            .frame(height: 150)
        }
    }
}

#Preview("AssignmentChartView") {
    AssignmentChartView(assignments: Gradebook.preview.courses[1].marks.first?.assignments ?? [])
}
