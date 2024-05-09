//
//  TodayScheduleView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/10/23.
//

import SwiftUI
import SwiftVue

struct TodayScheduleView: View {
    let todaySchedule: TodayScheduleInfoData
    
    var body: some View {
        if !todaySchedule.schoolInfos.isEmpty {
            ForEach(todaySchedule.schoolInfos) { schoolInfo in
                Section(schoolInfo.name) {
                    ForEach(schoolInfo.classes) { classInfo in
                        TimelineView(.periodic(from: .now, by: 1)) { timeline in
                            TodayScheduleListItemView(classInfo: classInfo, currentDate: timeline.date)
                        }
                    }
                }
            }
        } else {
            Text(String(localized: "SCHEDULE_NO_CLASSES_TODAY", defaultValue: "No classes today", comment: "Label to show if there are no classes today"))
                .foregroundStyle(.secondary)
        }
    }
}

#Preview("TodayScheduleView") {
    TodayScheduleView(todaySchedule: TodayScheduleInfoData.preview)
}
