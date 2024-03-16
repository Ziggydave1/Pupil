//
//  GradeBreakdownChartView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/10/24.
//

import SwiftUI
import SwiftVue
import Charts

struct GradeBreakdownChartView: View {
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
        let chartData = sorted
            .filter { $0.name != "TOTAL" }
        
        Chart(chartData) { element in
            BarMark(x: .value(String(localized: "BREAKDOWN_GRAPH_X", defaultValue: "Weight", comment: "The weight of the grade category"), element.weight))
                .foregroundStyle(by: .value(String(localized: "BREAKDOWN_GRAPH_DATA_NAME", defaultValue: "Name", comment: "The category name"), element.name))
        }
        .chartXAxis {
            AxisMarks(format: Decimal.FormatStyle.Percent.percent, values: .stride(by: 0.2))
        }
        .chartPlotStyle { plot in
            plot
                .cornerRadius(10)
        }
        .frame(height: 80)
    }
}

#Preview("GradeBreakdownChartView") {
    GradeBreakdownChartView(summary: [GradeCalculationPart.preview])
}
