//
//  AssignmentDetailView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/15/23.
//

import SwiftUI
import SwiftVue
import Defaults

struct AssignmentDetailView: View {
    @Default(.gradeColors) var gradeColors
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    var assignment: Assignment
    
    var body: some View {
        ZStack {
            List {
                Section {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(assignment.name.formattedRight())
                                .font(.body.weight(.medium))
                        }
                        Spacer()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Type")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(assignment.type.formattedRight())
                                .font(.body.weight(.medium))
                        }
                        Spacer()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Points")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(assignment.points)
                                .font(.body.weight(.medium))
                        }
                        Spacer()
                        CircularProgressView(progress: assignment.points.pointsToPercentage(), lineWidth: 4)
                            .frame(width: 20, height: 20)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Scoring")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(assignment.scoreType.formattedRight())
                                .font(.body.weight(.medium))
                        }
                        Spacer()
                        Text(assignment.score)
                            .font(.title2.weight(.bold))
                            .foregroundColor(gradeColors.color(for: "\(assignment.points.pointsToPercentage())", and: assignment.score))
                    }
                    HStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Date assigned")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(assignment.date)
                                    .font(.body.weight(.medium))
                            }
                            Spacer()
                        }
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Date due")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(assignment.due)
                                    .font(.body.weight(.medium))
                            }
                            Spacer()
                        }
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Description")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(assignment.description.formattedRight())
                                .font(.body.weight(.medium))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        Spacer()
                    }
                } header: {
                    Button {
                        dismiss()
                    } label: {
                        Label("Assignments", systemImage: "arrow.left")
                    }
                    .buttonStyle(.plain)
                }
            }
            .listStyle(.inset)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AssignmentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentDetailView(assignment: dev.assignment)
    }
}
