//
//  CourseRowView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 11/21/22.
//

import SwiftUI
import SwiftVue
import Defaults
import SwiftData

struct CourseRowView: View {
    @Default(.gradeColors) private var gradeColors
    @State private var showingAliasChooser: Bool = false
    @Query private var aliasLinks: [AliasLink]
    private let course: Course
    
    init(course: Course) {
        self.course = course
        self._aliasLinks = Query(filter: #Predicate<AliasLink> { $0.key == course.title }, animation: .default)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: alias?.icon ?? "studentdesk")
                    .frame(minWidth: 28, minHeight: 28, alignment: .center)
                    .font(.title2)
                VStack(alignment: .leading, spacing: 4) {
                    Text(alias?.name ?? course.title)
                        .font(.headline)
                    Text(String(localized: "COURSE_ROW_STAFF_ROOM_INFO", defaultValue: "\(course.staff) | Room \(course.room)", comment: "The room number and name of the teacher for a class"))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(4)
                
                Spacer()
            }
            ForEach(course.marks) { mark in
                Label {
                    Text(mark.name)
                } icon: {
                    Text(mark.scoreString)
                        .foregroundColor(gradeColors.color(for: mark.scoreRaw, and: mark.scoreString))
                }
            }
            .padding(1)
            .padding(.leading, 0)
            .font(.callout)
            .fontWeight(.semibold)
        }
        .contextMenu {
            GiveAliasButton(showingSheet: $showingAliasChooser)
            
            if let link = aliasLinks.first {
                RemoveAliasLinkButton(link: link)
            }
            
            Divider()
            
            EmailButtons(email: course.staffEmail)
        }
        .sheet(isPresented: $showingAliasChooser) {
            SelectAliasSheet(key: course.title)
        }
    }
    
    private var alias: Alias? {
        return aliasLinks.first?.value
    }
}

#Preview("CourseRowView") {
    CourseRowView(course: Course.preview)
}
