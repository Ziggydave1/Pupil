//
//  CalendarView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/27/23.
//

import SwiftUI
import SwiftVue

struct AttendanceView: View {
    @State private var attendance: Attendance?
    @State private var loading: Bool = false
    @State private var error: Error?
    @State private var selectedAbsence: Absence?
    var body: some View {
        NavigationStack {
            ZStack {
                if loading {
                    ProgressView()
                }
                List {
                    if let error {
                        Text(error.localizedDescription)
                            .font(.headline)
                            .foregroundStyle(.red)
                    }
                    if let attendance {
                        CalendarView(calendar: Calendar.current, selected: $selectedAbsence, attendance: attendance)
                    }
                    if let selectedAbsence {
                        AbsenceView(absence: selectedAbsence)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                .listStyle(.inset)
                .scrollDisabled(true)
                .refreshable {
                    Task {
                        let credentials = Credentials(username: "", password: "", districtURL: "")
                        let studentVue = StudentVue(credentials: credentials)
                        do {
                            self.loading = true
                            self.attendance = try await studentVue.getAttendance()
                            self.loading = false
                        } catch {
                            self.error = error
                        }
                    }
                }
            }
            .navigationTitle(String(localized: "ATTENDANCE_NAV_TITLE", defaultValue: "Attendance", comment: "Navigation title for the attendance page"))
        }
        .task {
            let credentials = Credentials(username: "", password: "", districtURL: "")
            let studentVue = StudentVue(credentials: credentials)
            do {
                self.loading = true
                self.attendance = try await studentVue.getAttendance()
                self.loading = false
            } catch {
                self.error = error
            }
        }
    }
}

struct AbsenceView: View {
    let absence: Absence
    var body: some View {
        VStack(alignment: .leading) {
//            Text("Date:" + absence.absenceDate.formatted())
//            Text("Reason: " + absence.reason)
//            Text("Periods:")
            ForEach(absence.periods) { period in
                VStack(alignment: .leading) {
                    Text(period.name)
                    Text(period.course)
                    Text(period.iconName)
                    Text(period.reason)
                    Text(period.schoolName)
                    Text(period.staff)
                    Text(period.staffEmail)
                    Text(String(period.number))
                }
            }
        }
    }
}

#Preview("AttendanceView") {
    AttendanceView()
}


struct CalendarView: UIViewRepresentable {
    let calendar: Calendar
    @Binding var selectedAbsence: Absence?
    let absences: [Absence]
    
    init(calendar: Calendar, selected: Binding<Absence?>, attendance: Attendance) {
        self.calendar = calendar
        self._selectedAbsence = selected
        self.absences = attendance.absences
    }
    
    func makeUIView(context: Context) -> UICalendarView {
        let calendarView = UICalendarView()
        calendarView.calendar = calendar
        calendarView.locale = context.environment.locale
        calendarView.timeZone = context.environment.timeZone
        calendarView.visibleDateComponents = calendar.dateComponents([.day, .month, .year], from: .now)
        calendarView.delegate = context.coordinator
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
        
        return calendarView
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) { }
    
    func makeCoordinator() -> CalendarViewCoordinator {
        CalendarViewCoordinator(calendar: calendar, selectedAbsence: _selectedAbsence, absences: absences)
    }
    
    class CalendarViewCoordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        let calendar: Calendar
        let selectedAbsence: Binding<Absence?>
        let absences: [Absence]
        
        init(calendar: Calendar, selectedAbsence: Binding<Absence?>, absences: [Absence]) {
            self.calendar = calendar
            self.selectedAbsence = selectedAbsence
            self.absences = absences
        }
        
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            guard let dateToCheck = dateComponents.date else {
                return nil
            }
            guard let absence = absences.first(where: { calendar.isDate(dateToCheck, inSameDayAs: $0.absenceDate) }) else {
                return nil
            }
            
            switch absence.dailyIconName {
            case "icon_unexcused.gif":
                return .default(color: .systemRed)
            case "icon_excused.gif":
                return .default(color: .systemGreen)
            default:
                return .default()
            }
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            guard let dateToCheck = dateComponents?.date else {
                if selectedAbsence.wrappedValue != nil {
                    withAnimation {
                        selectedAbsence.wrappedValue = nil
                    }
                }
                return
            }
            guard let absence = absences.first(where: { calendar.isDate(dateToCheck, inSameDayAs: $0.absenceDate) }) else {
                if selectedAbsence.wrappedValue != nil {
                    withAnimation {
                        selectedAbsence.wrappedValue = nil
                    }
                }
                return
            }
            if selectedAbsence.wrappedValue == nil {
                withAnimation {
                    selectedAbsence.wrappedValue = absence
                }
            } else {
                selectedAbsence.wrappedValue = absence
            }
        }
    }
}
