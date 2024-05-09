//
//  GradebookView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/14/23.
//

import SwiftUI
import SwiftVue
import Defaults
import Observation

struct GradebookView: View {
    @Environment(\.logout) private var logout
    @Environment(GradebookViewModel.self) private var vm
    
    var body: some View {
        @Bindable var vm = vm
        NavigationStack {
            List {
                Picker(String(localized: "GRADEBOOK_GRADING_PERIOD_PICKER", defaultValue: "Grading Period", comment: "The label for the grading period picker"), selection: $vm.gradebookPeriod) {
                    ForEach(vm.reportingPeriods) { period in
                        Text(period.name).tag(Optional(period))
                    }
                }
                .pickerStyle(.menu)
                .tint(.secondary)
                .disabled(vm.loading)
                
                if let error = vm.error {
                    Text(error.localizedDescription)
                        .font(.headline)
                        .foregroundColor(.red)
                }
                
                if let gradebook = vm.gradebook {
                    ForEach(gradebook.courses) { course in
                        if !course.marks.isEmpty {
                            NavigationLink(value: course) {
                                CourseRowView(course: course)
                            }
                        } else {
                            CourseRowView(course: course)
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
            .navigationTitle(String(localized: "GRADEBOOK_NAV_TITLE", defaultValue: "Gradebook", comment: "Navigation title for the gradebook page"))
            .navigationDestination(for: Course.self) { course in
                CourseDetailView(course: course)
            }
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
        .onChange(of: vm.gradebookPeriod) { oldValue, newValue in
            guard let oldValue else { return }
            if oldValue.name != newValue?.name {
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

#Preview("GradebookView") {
    GradebookView()
        .environment(GradebookViewModel(Credentials.preview))
}
