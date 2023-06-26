//
//  GradebookView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/14/23.
//

import SwiftUI

struct GradebookView: View {
    @EnvironmentObject private var vm: GradebookViewModel
    @Environment(\.logout) private var logout
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    if #available(iOS 16.0, *) {
                        Picker("Grading Period", selection: $vm.gradebookPeriod) {
                            ForEach(vm.reportingPeriods, id: \.self) { period in
                                Text(period).tag(period)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(.secondary)
                        .disabled(vm.loading)
                    } else {
                        HStack {
                            Text("Grading Period")
                            Spacer()
                            Menu {
                                Picker("", selection: $vm.gradebookPeriod) {
                                    ForEach(vm.reportingPeriods, id: \.self) { period in
                                        Text(period).tag(period)
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(.inline)
                                
                            } label: {
                                HStack(spacing: 5) {
                                    if vm.gradebookPeriod.count > 0 {
                                        Text(vm.gradebookPeriod)
                                        Image(systemName: "chevron.up.chevron.down")
                                    }
                                }
                                .foregroundColor(.secondary)
                            }
                            .disabled(vm.loading)
                        }
                    }
                    
                    if let error = vm.error {
                        Text(error)
                            .font(.body.weight(.semibold))
                            .foregroundColor(.red)
                    }
                    
                    if let gradebook = vm.gradebook {
                        ForEach(gradebook.courses) { course in
                            NavigationLink {
                                CourseDetailView(course: course)
                                    .navigationBarHidden(true)
                            } label: {
                                CourseRowView(course: course)
                            }
                        }
                    }
                }
                .listStyle(.inset)
                .navigationTitle("Grades")
                .refreshable {
                    if !vm.loading {
                        vm.refresh()
                    }
                }
                
                if vm.loading {
                    ProgressView()
                        .tint(.gray)
                }
            }
            .withLogout(logout)
        }
    }
}

struct GradebookView_Previews: PreviewProvider {
    static var previews: some View {
        GradebookView()
            .environmentObject(GradebookViewModel(credentials: dev.credentials, isPreview: true))
    }
}
