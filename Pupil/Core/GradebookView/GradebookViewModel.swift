//
//  GradebookViewModel.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/3/23.
//

import Foundation
import SwiftVue
import Defaults

class GradebookViewModel: ObservableObject {
    @Published var gradebook: Gradebook?
    @Published var gradebookPeriod: ReportPeriod?
    @Published var reportingPeriods: [ReportPeriod] = []
    @Published var loading: Bool = false
    @Published var error: Error?
    private let credentials: Credentials
    
    init(_ credentials: Credentials) {
        self.credentials = credentials
    }
    
    private var studentVue: StudentVue {
        return StudentVue(credentials: credentials)
    }
    
    @MainActor
    func loadData(termIndex: Int? = nil) async {
        loading = true
        await getGradebook(termIndex: termIndex)
        loading = false
    }
    
    @MainActor
    func refresh() async {
        if !loading {
            await getGradebook(termIndex: gradebookPeriod?.index)
        }
    }
    
    @MainActor
    private func getGradebook(termIndex: Int? = nil) async {
        gradebook = nil
        do {
            let result = try await studentVue.getGradebook(reportPeriod: termIndex)
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
