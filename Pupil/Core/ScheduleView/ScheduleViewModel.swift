//
//  ScheduleViewModel.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/16/23.
//

import Foundation
import SwiftVue
import Defaults

class ScheduleViewModel: ObservableObject {
    @Published var schedule: Schedule?
    @Published var selectedSchedule = Defaults[.openToTodaySchedule] ? "Today" : "Term"
    @Published var selectedTerm: TermListing?
    @Published var termListings: [TermListing] = []
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
        await getSchedule(termIndex: termIndex)
        loading = false
    }
    
    @MainActor
    func refresh() async {
        if !loading {
            await getSchedule(termIndex: selectedTerm?.termIndex)
        }
    }
    
    @MainActor
    private func getSchedule(termIndex: Int? = nil) async {
        schedule = nil
        do {
            let result = try await studentVue.getSchedule(termIndex: termIndex)
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
