//
//  ScheduleViewModel.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/16/23.
//

import Foundation
import SwiftVue
import Defaults
import Observation

@Observable
class ScheduleViewModel {
    var schedule: Schedule?
    var selectedSchedule = Defaults[.openToTodaySchedule] ? "Today" : "Term"
    var selectedTerm: TermListing?
    var termListings: [TermListing] = []
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
        await getSchedule()
        loading = false
        shouldViewLoadData = false
    }
    
    @MainActor
    func refresh() async {
        if !loading {
            await getSchedule()
        }
    }
    
    @MainActor
    private func getSchedule() async {
        schedule = nil
        do {
            let result = try await studentVue.getSchedule(termIndex: selectedTerm?.termIndex)
            schedule = result
            error = nil
            selectedTerm = result.termLists.first(where: { $0.termIndex == result.termIndex })
            termListings = result.termLists
        } catch {
            self.error = error
            return
        }
    }
}
