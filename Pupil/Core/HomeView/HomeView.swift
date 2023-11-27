//
//  HomeView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/14/23.
//

import SwiftUI
import SwiftVue
import Defaults

struct HomeView: View {
    @Default(.accentColor) private var accentColor
    private let credentials: Credentials
    
    @StateObject private var gradebookVM: GradebookViewModel
    @StateObject private var scheduleVM: ScheduleViewModel
    @StateObject private var studentVM: StudentViewModel
    
    init(credentials: Credentials) {
        self.credentials = credentials
        self._gradebookVM = StateObject(wrappedValue: GradebookViewModel(credentials))
        self._scheduleVM = StateObject(wrappedValue: ScheduleViewModel(credentials))
        self._studentVM = StateObject(wrappedValue: StudentViewModel(credentials))
    }
    
    var body: some View {
        TabView {
            GradebookView()
                .environmentObject(gradebookVM)
                .tabItem { Label(String(localized: "HOME_TAB_GRADEBOOK", defaultValue: "Gradebook", comment: "The gradebook tab"), systemImage: "menucard.fill") }
            
            ScheduleView()
                .environmentObject(scheduleVM)
                .tabItem { Label(String(localized: "HOME_TAB_SCHEDULE", defaultValue: "Schedule", comment: "The schedule tab"), systemImage: "list.bullet.rectangle.portrait.fill") }
            
            StudentView()
                .environmentObject(studentVM)
                .tabItem { Label(String(localized: "HOME_TAB_STUDENT_INFO", defaultValue: "Me", comment: "The me (student info) tab"), systemImage: "person.circle.fill") }
            
            SettingsView(credentials: credentials)
                .tabItem { Label(String(localized: "HOME_TAB_SETTINGS", defaultValue: "Settings", comment: "The settings tab"), systemImage: "gear") }
        }
        .tint(accentColor)
        .task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    await gradebookVM.loadData()
                }
                group.addTask {
                    await scheduleVM.loadData()
                }
                group.addTask {
                    await studentVM.loadData()
                }
            }
        }
    }
}

#Preview("HomeView") {
    HomeView(credentials: Credentials.preview)
}
