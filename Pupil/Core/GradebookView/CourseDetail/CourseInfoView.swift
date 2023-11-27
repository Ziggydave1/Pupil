//
//  CourseInfoView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 11/1/23.
//

import SwiftUI
import SwiftVue

struct CourseInfoView: View {
    @State private var showCopiedNotification: Bool = false
    let teacher: String
    let teacherEmail: String
    let room: String
    let period: Int
    
    init(course: Course) {
        self.teacher = course.staff
        self.teacherEmail = course.staffEmail
        self.room = course.room
        self.period = course.period
    }
    
    var body: some View {
        Section(String(localized: "COURSE_INFO_SECTION_HEADER", defaultValue: "Info", comment: "The section header for the course info")) {
            if !teacher.isEmpty {
                LabeledContent(String(localized: "COURSE_INFO_TEACHER", defaultValue: "Teacher", comment: "The teacher of the course")) {
                    Text(teacher)
                }
            }
            if !teacherEmail.isEmpty {
                LabeledContent(String(localized: "COURSE_INFO_STAFF_EMAIL", defaultValue: "Email", comment: "The email of the teacher of the course")) {
                    if showCopiedNotification {
                        Image(systemName: "doc.on.clipboard")
                            .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .leading)), removal: .opacity))
                            .foregroundColor(.secondary)
                    }
                    Text(teacherEmail.lowercased())
                        .foregroundColor(.secondary)
                        .contextMenu {
                            EmailButtons(email: teacherEmail)
                        }
                        .onTapGesture {
                            UIPasteboard.general.string = teacherEmail.lowercased()
                            withAnimation {
                                showCopiedNotification = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(.easeIn) {
                                    showCopiedNotification = false
                                }
                            }
                        }
                }
            }
            if !room.isEmpty {
                LabeledContent(String(localized: "COURSE_INFO_ROOM", defaultValue: "Room", comment: "The room number of the course")) {
                    Text(room)
                }
            }
        }
    }
    
    
}

#Preview("CourseInfoView") {
    CourseInfoView(course: Course.preview)
}
