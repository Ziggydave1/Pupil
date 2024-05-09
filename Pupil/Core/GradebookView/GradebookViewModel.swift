//
//  GradebookViewModel.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/3/23.
//

import Foundation
import SwiftVue
import Defaults
import Observation

@Observable
class GradebookViewModel {
    var gradebook: Gradebook?
    var gradebookPeriod: ReportPeriod?
    var reportingPeriods: [ReportPeriod] = []
    var loading: Bool = false
    var error: Error?
    var shouldViewLoadData = false
    private let credentials: Credentials
    
    init(_ credentials: Credentials) {
        self.credentials = credentials
    }
    
    private var studentVue: StudentVue {
        return StudentVue(credentials: credentials)
    }
    
    @MainActor
    func loadData() async {
        loading = true
        await getGradebook()
        loading = false
        shouldViewLoadData = false
    }
    
    @MainActor
    func refresh() async {
        if !loading {
            await getGradebook()
        }
    }
    
    @MainActor
    private func getGradebook() async {
        gradebook = nil
        do {
            let result = try await studentVue.getGradebook(reportPeriod: gradebookPeriod?.index)
            gradebook = result
            Defaults[.courseList] = result.courses.map({ $0.title })
            error = nil
            gradebookPeriod = result.reportingPeriods.first(where: { $0.name == result.reportingPeriod.name })
            reportingPeriods = result.reportingPeriods
        } catch {
            self.error = error
            return
        }
    }
}
