//
//  ScheduleView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/16/23.
//

import SwiftUI
import SwiftVue

struct ScheduleView: View {
    @EnvironmentObject private var vm: ScheduleViewModel
    @Environment(\.logout) private var logout
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    if #available(iOS 16.0, *) {
                        Picker("Schedule Period", selection: $vm.selectedPeriod) {
                            ForEach(vm.schedulePeriods, id: \.self) { period in
                                Text(period)
                            }
                        }
                        .tint(.secondary)
                        .pickerStyle(.menu)
                        .disabled(vm.loading)
                    } else {
                        HStack {
                            Text("Schedule Period")
                            Spacer()
                            Menu {
                                Picker("", selection: $vm.selectedPeriod) {
                                    ForEach(vm.schedulePeriods, id: \.self) { period in
                                        Text(period)
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(.inline)
                                
                            } label: {
                                HStack(spacing: 5) {
                                    if vm.schedulePeriods.count > 0 {
                                        Text(vm.selectedPeriod)
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
                    
                    if vm.selectedPeriod == "Today" {
                        ForEach(vm.schedule?.todaySchedule.schoolInfos ?? []) { schoolInfo in
                            Section(schoolInfo.name) {
                                ForEach(schoolInfo.classes) { classInfo in
                                    TodayScheduleListItemView(classInfo: classInfo, currentDate: $vm.date)
                                }
                            }
                        }
                        .onReceive(vm.timer) { _ in
                            vm.date = Date.now
                        }
                    } else {
                        ForEach(vm.schedule?.classLists ?? []) { classListing in
                            GeneralScheduleListItemView(classListing: classListing)
                        }
                        ForEach(vm.schedule?.concurrentClassSchedules ?? []) { concurrentSchedule in
                            Section(concurrentSchedule.schoolName) {
                                ForEach(concurrentSchedule.classLists) { classListing in
                                    GeneralScheduleListItemView(classListing: classListing)
                                }
                            }
                        }
                    }
                }
                .listStyle(.inset)
                .navigationTitle("Schedule")
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

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
            .environmentObject(ScheduleViewModel(credentials: dev.credentials, isPreview: true))
    }
}
