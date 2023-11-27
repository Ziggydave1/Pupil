//
//  GradeBreakdownView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 10/30/23.
//

import SwiftUI
import SwiftVue
import Defaults

struct GradeBreakdownView: View {
    @Default(.gradeColors) private var gradeColors
    var summary: [GradeCalculationPart]
    var body: some View {
        let sorted = summary
            .sorted {
                if $0.name == "TOTAL" {
                    return false
                } else if $1.name == "TOTAL" {
                    return true
                } else {
                    return $0.name < $1.name
                }
            }
        ForEach(sorted) { part in
            DisclosureGroup {
                LabeledContent(String(localized: "BREAKDOWN_POINTS", defaultValue: "Points", comment: "The points recieved out of the points possible for the category")) {
                    Text(part.points.numberFormatted() + "/" + part.pointsPossible.numberFormatted())
                }
                LabeledContent(String(localized: "BREAKDOWN_WEIGHT", defaultValue: "Weight", comment: "The weight the category is making out of the possible weight")) {
                    if part.calculatedMark != "0" && part.calculatedMark != "N/A" {
                        Text(part.weightedPct.percentFormatted() + "/" + part.weight.percentFormatted())
                    } else {
                        Text(part.weight.percentFormatted())
                    }
                }
            } label: {
                if part.calculatedMark != "0" {
                    Text(part.calculatedMark)
                        .fontWeight(.semibold)
                        .foregroundStyle(gradeColors.color(for: part.weightedPct * 100 / part.weight, and: part.calculatedMark))
                        .frame(width: 30)
                } else {
                    Text(String(localized: "BREAKDOWN_NA", defaultValue: "N/A", comment: "An N/A value for a part of a grade breakdown category"))
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .frame(width: 30)
                }
                Text(part.name)
            }
        }
    }
}

#Preview("GradeBreakdownView") {
    List {
        GradeBreakdownView(summary: Gradebook.preview.courses.first?.marks.first?.gradeCalculationSumary ?? [])
    }
    .listStyle(.inset)
}
