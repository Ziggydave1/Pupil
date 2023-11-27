//
//  StudentView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/19/23.
//

import SwiftUI
import SwiftVue

struct StudentView: View {
    @EnvironmentObject private var vm: StudentViewModel
    @Environment(\.logout) private var logout
    var body: some View {
        NavigationStack {
            List {
                if let studentInfo = vm.studentInfo {
                    Section {
                        NavigationLink {
                            IDCardView(info: studentInfo)
                        } label: {
                            IDCardRowView(info: studentInfo)
                        }
                    }
                    
                    Section(String(localized: "STUDENT_INFO_SECTION_HEADER_BASICS", defaultValue: "Basics", comment: "The section header for basics in the student info page")) {
                        if !studentInfo.gender.isEmpty {
                            StudentInfoRowView(image: "person.fill", color: .orange, name: String(localized: "STUDENT_INFO_GENDER_LABEL", defaultValue: "Gender", comment: "Label for student gender"), value: studentInfo.gender)
                        }
                        if !studentInfo.grade.isEmpty {
                            StudentInfoRowView(image: "graduationcap.fill", color: .green, name: String(localized: "STUDENT_INFO_GRADE_LABEL", defaultValue: "Grade", comment: "Label for student grade"), value: studentInfo.grade)
                        }
                        if !studentInfo.birthDate.isEmpty {
                            StudentInfoRowView(image: "calendar", color: .red, name: String(localized: "STUDENT_INFO_BIRTH_LABEL", defaultValue: "Birth Date", comment: "Label for student birth date"), value: studentInfo.birthDate)
                        }
                        if !studentInfo.address.isEmpty {
                            StudentInfoRowView(image: "house.fill", color: .blue, name: String(localized: "STUDENT_INFO_ADDRESS_LABEL", defaultValue: "Address", comment: "Label for student address"), value: studentInfo.address)
                        }
                        if !studentInfo.email.isEmpty {
                            StudentInfoRowView(image: "envelope.fill", color: .blue, name: String(localized: "STUDENT_INFO_EMAIL_LABEL", defaultValue: "Email", comment: "Label for student email"), value: studentInfo.email.lowercased())
                                .contextMenu {
                                    if let url = URL(string: "mailto:\(studentInfo.email)") {
                                        Link(String(localized: "EMAIL_BUTTON", defaultValue: "Email", comment: "Button to email"), destination: url)
                                    } else {
                                        Text("\(studentInfo.email)")
                                    }
                                }
                        }
                        if !studentInfo.phone.isEmpty {
                            StudentInfoRowView(image: "phone.fill", color: .green, name: String(localized: "STUDENT_INFO_PHONE_LABEL", defaultValue: "Phone", comment: "Label for student phone number"), value: studentInfo.phone)
                                .contextMenu {
                                    if let url = URL(string: "tel:\(studentInfo.phone)") {
                                        Link(String(localized: "CALL_BUTTON", defaultValue: "Call", comment: "Button to call"), destination: url)
                                    } else {
                                        Text("\(studentInfo.phone)")
                                    }
                                }
                        }
                    }
                    
                    Section(String(localized: "STUDENT_INFO_SECTION_HEADER_DETAILS", defaultValue: "Details", comment: "The section header fot details in the student info page")) {
                        if !studentInfo.emergencyContacts.isEmpty {
                            DisclosureGroup {
                                EmergencyContactsView(info: studentInfo)
                            } label: {
                                StudentInfoRowView(image: "exclamationmark.shield.fill", color: .red, name: String(localized: "STUDENT_INFO_EMERGENCY_CONTACTS_LABEL", defaultValue: "Emergency Contacts", comment: "Label for the emergency contacts disclosure group"))
                            }
                        }
                        if !studentInfo.dentist.name.isEmpty || !studentInfo.physician.name.isEmpty {
                            DisclosureGroup {
                                DoctorsView(info: studentInfo)
                            } label: {
                                StudentInfoRowView(image: "staroflife.fill", color: .blue, name: String(localized: "STUDENT_INFO_DOCTORS_LABEL", defaultValue: "Doctors", comment: "Label for the doctors disclosure group"))
                            }
                        }
                        if !studentInfo.userDefinedGroupBoxes.isEmpty {
                            DisclosureGroup {
                                OtherInfoView(info: studentInfo)
                            } label: {
                                StudentInfoRowView(image: "person.crop.circle.badge.fill", color: .orange, name: String(localized: "STUDENT_INFO_OTHER_LABEL", defaultValue: "Other", comment: "Label for the other disclosure group"))
                            }
                        }
                    }
                }
            }
            .listStyle(.inset)
            .overlay {
                if vm.loading {
                    ProgressView()
                        .tint(.secondary)
                }
            }
            .refreshable {
                await vm.refresh()
            }
            .navigationTitle(String(localized: "STUDENT_INFO_NAV_TITLE", defaultValue: "Me", comment: "Navigation title for the student info page"))
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(String(localized: "LOG_OUT_BUTTON_TEXT", defaultValue: "Log Out")) {
                        logout()
                    }
                    .tint(.red)
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

#Preview("StudentView") {
    StudentView()
        .environmentObject(StudentViewModel(Credentials.preview))
}
