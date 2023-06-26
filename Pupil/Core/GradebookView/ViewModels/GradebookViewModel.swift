//
//  GradebookViewModel.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/15/23.
//

import Foundation
import SwiftVue
import Defaults

class GradebookViewModel: ObservableObject {
    let studentVue: StudentVue
    
    @Published var gradebook: Gradebook?
    @Published var loading: Bool = false
    @Published var gradebookPeriod: String = "" {
        didSet {
            if gradebookPeriod != gradebook?.reportingPeriod.name {
                let index = gradebook?.reportingPeriods.first(where: { period in
                    period.name == gradebookPeriod
                })?.index
                Task {
                    if let index {
                        await loadData(termIndex: Int(index))
                    } else {
                        await loadData()
                    }
                }
            }
        }
    }
    
    @Published var error: String?
    
    var reportingPeriods: [String] {
        guard let gradebook else {
            return []
        }
        
        return gradebook.reportingPeriods.map { period in
            period.name
        }
    }
    
    init(credentials: Credentials, isPreview: Bool = false) {
        self.studentVue = StudentVue(credentials: credentials)
        if isPreview {
            self.gradebook = PreviewData.instance.multiMarkGradebook
            self.gradebookPeriod = PreviewData.instance.multiMarkGradebook.reportingPeriod.name
        }
    }
    
    @MainActor
    func loadData(termIndex: Int? = nil) async {
        loading = true
        await getGradebook(termIndex: termIndex)
        loading = false
    }
    
    func refresh() {
        Task {
            await loadData(termIndex: reportingPeriods.firstIndex(where: { period in
                period == gradebookPeriod
            }))
        }
    }
    
    @MainActor
    private func getGradebook(termIndex: Int? = nil) async {
        gradebook = nil
        let result = await studentVue.getGradebook(reportPeriod: termIndex)
        switch result {
        case .success(let success):
            gradebook = success
            Defaults[.courseList] = success.courses.map({ $0.title })
            error = nil
            gradebookPeriod = success.reportingPeriod.name
        case .failure(let err):
            error = err.localizedDescription
            return
        }
    }
}
