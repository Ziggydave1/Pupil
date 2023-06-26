//
//  CourseDetailView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/15/23.
//

import SwiftUI
import SwiftVue
import Defaults

struct CourseDetailView: View {
    @Default(.gradeColors) var gradeColors
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    var course: Course
    @State private var selectedMark: Mark?
    @State private var showAliasSheet: Bool = false
    @State private var showCopiedNotification: Bool = false
    
    @FetchRequest var aliasLinks: FetchedResults<AliasLink>
    
    init(course: Course) {
        self.course = course
        _selectedMark = State(initialValue: course.marks.first)
        self._aliasLinks = FetchRequest<AliasLink>(sortDescriptors: [], predicate: NSPredicate(format: "key = %@", course.title))
    }
    
    var body: some View {
        ZStack {
            gradeColors.color(for: selectedMark?.scoreRaw, and: selectedMark?.scoreString)
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Label(aliasLinks.first?.value?.name ?? course.title, systemImage: aliasLinks.first?.value?.icon ?? "studentdesk")
                        .foregroundColor(.white)
                        .font(.title3.weight(.semibold))
                        .shadow(radius: colorScheme == .dark ? 8 : 5)
                        .contextMenu {
                            Button {
                                showAliasSheet = true
                            } label: {
                                Text("Give alias")
                                Image(systemName: "pencil")
                            }
                            
                            if let link = aliasLinks.first {
                                Button(role: .destructive) {
                                    PersistenceController.shared.delete(link)
                                } label: {
                                    Text("Remove Alias")
                                    Image(systemName: "trash")
                                }
                                
                            }

                        }
                    
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title.weight(.semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                        }
                        
                        ZStack {
                            Circle()
                                .frame(width: 120, height: 120)
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .shadow(radius: colorScheme == .dark ? 8 : 5)
                                .overlay {
                                    Circle()
                                        .trim(from: 0, to: (Double(selectedMark?.scoreRaw ?? "0") ?? 0) / 100)
                                        .stroke(gradeColors.color(for: selectedMark?.scoreRaw, and: selectedMark?.scoreString), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                                        .rotationEffect(.degrees(270))
                                        .padding(5)
                                }
                            
                            VStack(spacing: (selectedMark?.scoreString == "N/A" || selectedMark?.scoreString == nil) ? 0 : -6) {
                                Text(selectedMark?.scoreString ?? "N/A")
                                    .font(.system(size: 44, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)
                                Text("\(selectedMark?.scoreRaw ?? "0")%")
                                    .font(.system(size: 17, weight: .semibold))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button {
                            showAliasSheet = true
                        } label: {
                            Image(systemName: "pencil")
                                .font(.title.weight(.semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    if selectedMark != nil && course.marks.count > 1 {
                        if #available(iOS 16.0, *) {
                            Picker("Mark", selection: $selectedMark) {
                                ForEach(course.marks) { mark in
                                    Text(mark.name)
                                        .tag(Optional(mark))
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(.white)
                            .background(.black.opacity(0.1))
                            .cornerRadius(10)
                        } else {
                            Menu {
                                Picker("", selection: $selectedMark) {
                                    ForEach(course.marks) { mark in
                                        Text(mark.name).tag(Optional(mark))
                                    }
                                }
                                .labelsHidden()
                                .pickerStyle(.inline)
                                
                            } label: {
                                HStack(spacing: 5) {
                                    Text(selectedMark?.name ?? "")
                                    Image(systemName: "chevron.up.chevron.down")
                                }
                                .font(.body)
                            }
                            .padding(10)
                            .tint(.white)
                            .background(.black.opacity(0.1))
                            .cornerRadius(10)
                            .padding(.top, 7)
                        }
                    }
                }
                .font(.system(size: 28, weight: .semibold))
                .padding(10)
                
                NavigationView {
                    List {
                        Section("Info") {
                            HStack {
                                Text("Teacher")
                                Spacer()
                                Text(course.staff)
                                    .foregroundColor(.secondary)
                            }
                            HStack {
                                Text("Email")
                                Spacer()
                                if showCopiedNotification {
                                    Image(systemName: "doc.on.clipboard")
                                        .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .leading)), removal: .opacity))
                                        .foregroundColor(.secondary)
                                }
                                Text(course.staffEmail.lowercased())
                                    .foregroundColor(.secondary)
                                    .contextMenu {
                                        if course.staffEmail.count > 0 {
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
                                    .onTapGesture {
                                        UIPasteboard.general.string = course.staffEmail.lowercased()
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
                        if !(selectedMark?.gradeCalculationSumary.isEmpty ?? true) {
                            Section("Grade Breakdown") {
                                ForEach(selectedMark?.gradeCalculationSumary.sorted(by: { $1.name == "TOTAL" || $0.name < $1.name }) ?? []) { part in
                                    HStack {
                                        Text(part.name)
                                        Spacer()
                                        Text(part.weight)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                        Section("Assignments") {
                            ForEach(selectedMark?.assignments ?? []) { entry in
                                NavigationLink {
                                    AssignmentDetailView(assignment: entry)
                                        .navigationBarHidden(true)
                                } label: {
                                    AssignmentRowView(assignment: entry)
                                        .padding(.vertical, 2)
                                }
                            }
                        }
                    }
                    .listStyle(.inset)
                    .navigationBarHidden(true)
                }
                .navigationViewStyle(.stack)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .ignoresSafeArea()
                .shadow(radius: colorScheme == .dark ? 8 : 5)
            }
        }
        .sheet(isPresented: $showAliasSheet) {
            SelectAliasSheet(key: course.title)
        }
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(course: dev.multiMarkCourse)
    }
}

