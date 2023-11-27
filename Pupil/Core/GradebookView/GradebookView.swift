//
//  GradebookView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/14/23.
//

import SwiftUI
import SwiftVue
import Defaults

struct GradebookView: View {
    @EnvironmentObject private var vm: GradebookViewModel
    @Environment(\.logout) private var logout
    
    var body: some View {
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
        .onChange(of: vm.gradebookPeriod) { newPeriod in
            if newPeriod?.name != vm.gradebook?.reportingPeriod.name {
                Task {
                    await vm.loadData(termIndex: newPeriod?.index)
                }
            }
        }
    }
}

#Preview("GradebookView") {
    GradebookView()
        .environmentObject(GradebookViewModel(Credentials.preview))
}
