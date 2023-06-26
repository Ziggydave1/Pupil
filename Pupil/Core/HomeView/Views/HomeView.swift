//
//  HomeView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/14/23.
//

import SwiftUI
import SwiftVue

struct HomeView: View {
    @StateObject private var gradebookVM: GradebookViewModel
    @StateObject private var scheduleVM: ScheduleViewModel
    @StateObject private var studentInfoVM: StudentViewModel
    @StateObject private var settingsVM: SettingsViewModel
    var credentials: Credentials
    
    init(credentials: Credentials) {
        self.credentials = credentials
        _gradebookVM = StateObject(wrappedValue: GradebookViewModel(credentials: credentials))
        _scheduleVM = StateObject(wrappedValue: ScheduleViewModel(credentials: credentials))
        _studentInfoVM = StateObject(wrappedValue: StudentViewModel(credentials: credentials))
        _settingsVM = StateObject(wrappedValue: SettingsViewModel(credentials: credentials))
    }
    
    var body: some View {
        TabView {
            GradebookView()
                .environmentObject(gradebookVM)
                .tabItem {
                    Label("Gradebook", systemImage: "menucard.fill")
                }
            ScheduleView()
                .environmentObject(scheduleVM)
                .tabItem {
                    Label("Schedule", systemImage: "list.bullet.rectangle.portrait.fill")
                }
            StudentView()
                .environmentObject(studentInfoVM)
                .tabItem {
                    Label("Me", systemImage: "person.circle.fill")
                }
            SettingsView()
                .environmentObject(settingsVM)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .navigationViewStyle(.stack)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
        .task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask(priority: .userInitiated) {
                    await gradebookVM.loadData()
                }
                group.addTask(priority: .userInitiated) {
                    await scheduleVM.loadData()
                }
                group.addTask(priority: .userInitiated) {
                    await studentInfoVM.loadData()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(credentials: dev.credentials)
    }
}
