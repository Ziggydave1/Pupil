//
//  GeneralScheduleView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/10/23.
//

import SwiftUI
import SwiftVue

struct GeneralScheduleView: View {
    let schedule: Schedule
    var body: some View {
        if !schedule.classLists.isEmpty || !schedule.concurrentClassSchedules.isEmpty {
            ForEach(schedule.classLists) { classListing in
                GeneralScheduleListItemView(classListing: classListing)
            }
            ForEach(schedule.concurrentClassSchedules) { concurrentSchedule in
                Section(concurrentSchedule.schoolName) {
                    ForEach(concurrentSchedule.classLists) { classListing in
                        GeneralScheduleListItemView(classListing: classListing)
                    }
                }
            }
        } else {
            Text(String(localized: "SCHEDULE_NO_CLASSES", defaultValue: "No classes", comment: "The label to show if there are no classes scheduled at all"))
                .foregroundStyle(.secondary)
        }
    }
}

#Preview("GeneralScheduleView") {
    GeneralScheduleView(schedule: Schedule.preview)
}
