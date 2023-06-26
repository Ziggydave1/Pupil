//
//  ScheduleViewModel.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/16/23.
//

import Foundation
import SwiftVue

class ScheduleViewModel: ObservableObject {
    let studentVue: StudentVue
    
    @Published var schedule: Schedule?
    @Published var loading: Bool = false
    @Published var selectedPeriod: String = "" {
        didSet {
            if selectedPeriod != schedule?.termIndexName && selectedPeriod != "Today" {
                let index = schedule?.termLists.first(where: { term in
                    term.termName == selectedPeriod
                })?.termIndex
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
    
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var date: Date = Date.now
    
    var schedulePeriods: [String] {
        guard let schedule else {
            return []
        }
        
        var periods: [String] = ["Today"]

        periods.append(contentsOf: schedule.termLists.map { term in
            term.termName
        })
        
        return periods
    }
    
    init(credentials: Credentials, isPreview: Bool = false) {
        self.studentVue = StudentVue(credentials: credentials)
        if isPreview {
            self.schedule = PreviewData.instance.schedule
            self.selectedPeriod = PreviewData.instance.schedule.termIndexName
        }
    }
    
    @MainActor
    func loadData(termIndex: Int? = nil) async {
        loading = true
        await getSchedule(termIndex: termIndex)
        loading = false
    }
    
    func refresh() {
        let index = schedule?.termLists.first(where: { term in
            term.termName == selectedPeriod
        })?.termIndex
        Task {
            if let index {
                await loadData(termIndex: Int(index))
            } else {
                await loadData()
            }
        }
    }
    
    @MainActor
    private func getSchedule(termIndex: Int? = nil) async {
        schedule = nil
        let result = await studentVue.getSchedule(termIndex: termIndex)
        switch result {
        case .success(let success):
            schedule = success
            error = nil
            if termIndex != nil {
                selectedPeriod = success.termIndexName
            } else {
                selectedPeriod = "Today"
            }
        case .failure(let err):
            error = err.localizedDescription
            return
        }
    }
}
