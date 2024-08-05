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
    var course: Course
    @State private var selectedMark: Mark
    @State private var selectedTab: String = "Assignments"
    @State private var showAliasSheet: Bool = false
    @State private var assignments: [Assignment]
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.key)]) var aliasLinks: FetchedResults<AliasLink>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var aliases: FetchedResults<Alias>
    
    @State private var sortingKey: SortingKey = .date
    @State private var shouldSort = true
    @State private var order: SortOrder = .forward
    
    enum SortingKey: Hashable, CaseIterable {
        case date
        case due
        case alphabetical
        
        var displayName: String {
            switch self {
            case .date: return String(localized: "SORTING_KEY_DATE", defaultValue: "Date Assigned", comment: "Sort assignments by date assigned")
            case .due: return String(localized: "SORTING_KEY_DUE", defaultValue: "Date Due", comment: "Sort assignments by date due")
            case .alphabetical: return String(localized: "SORTING_KEY_ALPHA", defaultValue: "Alphabetical", comment: "Sort assignments alphabetically")
            }
        }
    }
    
    init(course: Course) {
        self.course = course
        self._selectedMark = State(initialValue: course.marks.first!)
        self._assignments = State(initialValue: course.marks.first!.assignments.sorted(using: KeyPathComparator(\Assignment.date)))
    }
    
    var body: some View {
        List {
            CourseInfoView(course: course)
            
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Text(selectedMark.scoreString)
                        
                        
                        if selectedMark.scoreString != "N/A" {
                            Text(selectedMark.scoreRaw.rawScoreFormatted())
                                .font(.title2)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Picker(String(localized: "COURSE_MARK_PICKER", defaultValue: "Mark", comment: "Label for the mark picker in a course"), selection: $selectedMark) {
                            ForEach(course.marks) { mark in
                                Text(mark.name)
                                    .tag(mark)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(.menu)
                        .tint(.secondary)
                    }
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .dynamicTypeSize(...DynamicTypeSize.accessibility3)
                    
                    ProgressView(value: selectedMark.scoreRaw, total: 100)
                        .tint(gradeColors.color(for: selectedMark.scoreRaw, and: selectedMark.scoreString))
                }
                .padding(.vertical, 10)
                
                if !selectedMark.gradeCalculationSumary.isEmpty {
                    Picker(String(localized: "COURSE_ASSIGNMENTS_OR_BREAKDOWN_PICKER", defaultValue: "Section", comment: "Label for the picker to switch between viewing assignments and the grade breakdown"), selection: $selectedTab) {
                        Text(String(localized: "COURSE_ASSIGNMENTS_SECTION", defaultValue: "Assignments", comment: "The assignments option for the section picker")).tag("Assignments")
                        Text(String(localized: "COURSE_BREAKDOWN_SECTION", defaultValue: "Breakdown", comment: "The breakdown option for the section picker")).tag("Breakdown")
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
                
                if selectedTab == "Assignments" {
                    AssignmentChartView(assignments: selectedMark.assignments.sorted(using: KeyPathComparator(\Assignment.date)))
                        .padding(.top)
                } else if selectedTab == "Breakdown" {
                    GradeBreakdownChartView(summary: selectedMark.gradeCalculationSumary)
                        .padding(.top)
                }
            }
            .listRowSeparator(.hidden)
            
            if selectedTab == "Assignments" {
                if !assignments.isEmpty {
                    Section {
                        ForEach(assignments) { entry in
                            AssignmentView(assignment: entry)
                        }
                    } header: {
                        Menu(String(localized: "COURSE_SORT_ASSIGNMENTS_MENU", defaultValue: "Sort", comment: "Shows the sorting options for the assignment list"), systemImage: "arrow.up.arrow.down") {
                            Picker(String(localized: "COURSE_SORT_KET_PICKER", defaultValue: "Sort by", comment: "Picker to choose what to sort assignments by"), selection: $sortingKey) {
                                ForEach(SortingKey.allCases, id: \.self) { sortingkey in
                                    Text(sortingkey.displayName)
                                        .tag(sortingkey)
                                }
                            }
                            Picker(String(localized: "COURSE_SORT_ORDER_PICKER", defaultValue: "Order", comment: "Picker to choose the direction of sorting"), selection: $order) {
                                Text(String(localized: "COURSE_SORT_ORDER_FORWARD", defaultValue: "Forward", comment: "Forward sorting direction")).tag(SortOrder.forward)
                                Text(String(localized: "COURSE_SORT_ORDER_REVERSE", defaultValue: "Reverse", comment: "Reverse sorting direction")).tag(SortOrder.reverse)
                            }
                        }
                        .onChange(of: sortingKey) { _ in
                            guard shouldSort else {
                                shouldSort = true
                                return
                            }
                            withAnimation {
                                sort(assignments: selectedMark.assignments)
                            }
                        }
                        .onChange(of: order) { _ in
                            guard shouldSort else {
                                shouldSort = true
                                return
                            }
                            withAnimation {
                                sort(assignments: selectedMark.assignments)
                            }
                        }
                    }
                }
            } else if selectedTab == "Breakdown" {
                let summary = selectedMark.gradeCalculationSumary
                if !summary.isEmpty {
                    Section {
                        GradeBreakdownView(summary: summary)
                    }
                }
            }
        }
        .listStyle(.inset)
        .navigationTitle(alias?.name ?? course.title)
        .toolbar {
            if PersistenceController.shared.enabled {
                ToolbarItem(placement: .primaryAction) {
                    Menu(String(localized: "COURSE_EDIT_BUTTON", defaultValue: "Edit", comment: "Button to pull up the alias picker when wanting to customize a course")) {
                        GiveAliasButton(showingSheet: $showAliasSheet)
                        
                        if let aliasLink {
                            RemoveAliasLinkButton(link: aliasLink)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showAliasSheet) {
            SelectAliasSheet(key: course.title)
        }
        .onChange(of: selectedMark) { newValue in
            assignments = newValue.assignments.sorted(using: KeyPathComparator(\Assignment.date))
            shouldSort = false
            sortingKey = .date
        }
    }
    
    var aliasLink: AliasLink? {
        return aliasLinks.first { $0.key == course.title }
    }
    
    var alias: Alias? {
        return aliases.first(where: { $0.objectID == aliasLink?.value?.objectID })
    }
    
    func sort(assignments: [Assignment]) {
        switch sortingKey {
        case .date:
            self.assignments = assignments.sorted(using: KeyPathComparator(\Assignment.date, order: order))
        case .due:
            self.assignments = assignments.sorted(using: KeyPathComparator(\Assignment.due, order: order))
        case .alphabetical:
            self.assignments = assignments.sorted(using: KeyPathComparator(\Assignment.name, order: order))
        }
    }
}

#Preview("CourseDetailView") {
    NavigationStack {
        CourseDetailView(course: Course.preview)
    }
}
