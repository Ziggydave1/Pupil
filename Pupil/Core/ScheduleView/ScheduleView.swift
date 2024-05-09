//
//  ScheduleView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/16/23.
//

import SwiftUI
import SwiftVue
import Observation

struct ScheduleView: View {
    @Environment(\.logout) private var logout
    @Environment(ScheduleViewModel.self) private var vm
    
    var body: some View {
        @Bindable var vm = vm
        NavigationStack {
            List {
                Picker(String(localized: "SCHEDULE_TYPE_PICKER", defaultValue: "Schedule Type", comment: "Picker for the schedule type"), selection: $vm.selectedSchedule) {
                    Text(String(localized: "SCHEDULE_TODAY_TYPE", defaultValue: "Today", comment: "The today type of schedule")).tag("Today")
                    Text(String(localized: "SCHEDULE_TERM_TYPE", defaultValue: "Term", comment: "The term type of schedule")).tag("Term")
                }
                .pickerStyle(.segmented)
                .disabled(vm.loading)
                
                if let error = vm.error {
                    Text(error.localizedDescription)
                        .font(.headline)
                        .foregroundColor(.red)
                }
                
                if let schedule = vm.schedule {
                    if vm.selectedSchedule == "Today" {
                        TodayScheduleView(todaySchedule: schedule.todaySchedule)
                    } else {
                        Section(String(localized: "SCHEDULE_TERM_TYPE_SECTION_LABEL", defaultValue: "Term Schedule", comment: "The section header label for the term schedule type")) {
                            Picker(String(localized: "SCHEDULE_TERM_PICKER", defaultValue: "Schedule Period", comment: "The label for the schedule term picker"), selection: $vm.selectedTerm) {
                                ForEach(vm.termListings, id: \.self) { period in
                                    Text(period.termName).tag(Optional(period))
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(.secondary)
                            .disabled(vm.loading)
                            
                            GeneralScheduleView(schedule: schedule)
                        }
                    }
                }
            }
            .listStyle(.inset)
            .overlay {
                if vm.loading {
                    ProgressView()
                        .tint(.secondary)
                }
            }
            .refreshable {
                await vm.refresh()
            }
            .navigationTitle(String(localized: "SCHEDULE_NAV_TITLE", defaultValue: "Schedule", comment: "Navigation title for the schedule page"))
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(String(localized: "LOG_OUT_BUTTON_TEXT", defaultValue: "Log Out")) {
                        logout()
                    }
                    .tint(.red)
                    .buttonStyle(.bordered)
                }
            }
        }
        .onChange(of: vm.selectedTerm) { oldTerm, newTerm in
            guard let oldTerm else { return }
            if oldTerm.termIndex != newTerm?.termIndex {
                vm.shouldViewLoadData = true
            }
        }
        .task(id: vm.shouldViewLoadData) {
            if vm.shouldViewLoadData {
                await vm.loadData()
            }
        }
    }
}

#Preview("ScheduleView") {
    ScheduleView()
        .environment(ScheduleViewModel(Credentials.preview))
}
