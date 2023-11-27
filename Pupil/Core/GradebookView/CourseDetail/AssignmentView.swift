//
//  AssignmentView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/3/23.
//

import SwiftUI
import SwiftVue
import Defaults

struct AssignmentView: View {
    @Default(.gradeColors) var gradeColors
    var assignment: Assignment
    var body: some View {
        DisclosureGroup {
            HStack {
                VStack(alignment: .leading) {
                    Text(String(localized: "ASSIGNMENT_NAME", defaultValue: "Name", comment: "The name of the assignment"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(assignment.name.formattedRight())
                        .font(.body)
                        .fontWeight(.medium)
                }
                Spacer()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(String(localized: "ASSIGNMENT_TYPE", defaultValue: "Type", comment: "The type of the assignment"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(assignment.type.formattedRight())
                        .font(.body)
                        .fontWeight(.medium)
                }
                Spacer()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(String(localized: "ASSIGNMENT_POINTS", defaultValue: "Points", comment: "The points of the assignment"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(assignment.points)
                        .font(.body)
                        .fontWeight(.medium)
                }
                Spacer()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(String(localized: "ASSIGNMENT_SCORING", defaultValue: "Scoring", comment: "The scoring type of the assignment"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(assignment.scoreType.formattedRight())
                        .font(.body)
                        .fontWeight(.medium)
                }
                Spacer()
                Text(assignment.score)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(gradeColors.color(for: assignment.points.pointsToPercentage(), and: assignment.score))
            }
            HStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(String(localized: "ASSIGNMENT_DATE", defaultValue: "Date assigned", comment: "The date assigned of the assignment"))
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(assignment.date.formatted(date: .abbreviated, time: .omitted))
                            .font(.body)
                            .fontWeight(.medium)
                    }
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(String(localized: "ASSIGNMENT_DUE", defaultValue: "Date due", comment: "The date due of the assignment"))
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(assignment.due.formatted(date: .abbreviated, time: .omitted))
                            .font(.body)
                            .fontWeight(.medium)
                    }
                    Spacer()
                }
            }
            if assignment.description.count != 0 {
                HStack {
                    VStack(alignment: .leading) {
                        Text(String(localized: "ASSIGNMENT_DESRIPTION", defaultValue: "Description", comment: "The description of the assignment"))
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(assignment.description.formattedRight())
                            .font(.body)
                            .fontWeight(.medium)
                    }
                    Spacer()
                }
            }
        } label: {
            HStack {
                CircularProgressView(progress: assignment.points.pointsToPercentage(), lineWidth: 4)
                    .frame(width: 25)
                VStack(alignment: .leading) {
                    Text(assignment.name.formattedRight())
                        .font(.headline)
                    Text(assignment.points)
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                .padding(.horizontal, 8)
                Spacer()
            }
            .padding(.vertical, 2)
        }
    }
}

#Preview("AssignmentView") {
    List {
        AssignmentView(assignment: Assignment.preview)
    }
    .listStyle(.inset)
}
