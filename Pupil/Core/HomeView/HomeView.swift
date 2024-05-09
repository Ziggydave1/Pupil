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
    @State private var gradebookVM: GradebookViewModel
    @State private var scheduleVM: ScheduleViewModel
    @State private var studentVM: StudentViewModel
    private let credentials: Credentials
    
    init(credentials: Credentials) {
        self.credentials = credentials
        self.gradebookVM = GradebookViewModel(credentials)
        self.scheduleVM = ScheduleViewModel(credentials)
        self.studentVM = StudentViewModel(credentials)
    }
    
    var body: some View {
        TabView {
            GradebookView()
                .environment(gradebookVM)
                .tabItem { Label(String(localized: "HOME_TAB_GRADEBOOK", defaultValue: "Gradebook", comment: "The gradebook tab"), systemImage: "menucard.fill") }
            
            ScheduleView()
                .environment(scheduleVM)
                .tabItem { Label(String(localized: "HOME_TAB_SCHEDULE", defaultValue: "Schedule", comment: "The schedule tab"), systemImage: "list.bullet.rectangle.portrait.fill") }
            
            StudentView()
                .environment(studentVM)
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
