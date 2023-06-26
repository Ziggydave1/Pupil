//
//  CourseRowView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 11/21/22.
//

import SwiftUI
import SwiftVue
import Defaults

struct CourseRowView: View {
    @Default(.gradeColors) var gradeColors
    @State private var showingAliasChooser: Bool = false
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)],
        animation: .default
    ) private var aliases: FetchedResults<Alias>
    var course: Course
    
    @FetchRequest var aliasLinks: FetchedResults<AliasLink>
    
    init(course: Course) {
        self.course = course
        self._aliasLinks = FetchRequest<AliasLink>(sortDescriptors: [], predicate: NSPredicate(format: "key = %@", course.title))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: aliases.first(where: { $0.objectID == aliasLinks.first?.value?.objectID })?.icon ?? "studentdesk")
                    .frame(minWidth: 28, minHeight: 28, alignment: .center)
                    .font(.title2)
                VStack(alignment: .leading, spacing: 4) {
                    Text(aliases.first(where: { $0.objectID == aliasLinks.first?.value?.objectID })?.name ?? course.title)
                        .font(.headline)
                    Text("\(course.staff) | Room \(course.room)")
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
            .font(.callout.weight(.semibold))
        }
        .contextMenu {
            Button {
                showingAliasChooser.toggle()
            } label: {
                Label("Give Alias", systemImage: "pencil")
            }
            
            if let link = aliasLinks.first {
                Button(role: .destructive) {
                    PersistenceController.shared.delete(link)
                } label: {
                    Text("Remove Alias")
                    Image(systemName: "trash")
                }

            }
            
            if course.staffEmail.count > 0 {
                Divider()
                Button {
                    UIPasteboard.general.string = course.staffEmail.lowercased()
                } label: {
                    Text("Copy Email")
                    Image(systemName: "doc.on.doc")
                }
                
                if let emailURL = URL(string: "mailto:" + course.staffEmail.lowercased()) {
                    Link(destination: emailURL) {
                        Text("Compose Email")
                        Image(systemName: "envelope")
                    }
                    
                }
            }
        }
        .sheet(isPresented: $showingAliasChooser) {
            SelectAliasSheet(key: course.title)
        }
    }
}

struct CourseRowView_Previews: PreviewProvider {
    static var previews: some View {
        CourseRowView(course: dev.multiMarkCourse)
    }
}
