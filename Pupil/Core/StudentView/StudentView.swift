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
                if let error = vm.error {
                    Text(error.localizedDescription)
                        .font(.headline)
                        .foregroundColor(.red)
                }
                
                if let studentInfo = vm.studentInfo {
                    Section {
                        NavigationLink {
                            IDCardView(info: studentInfo)
                        } label: {
                            IDCardRowView(info: studentInfo)
                        }
                    }
                    
                    Section(
                        String(
                            localized: "STUDENT_INFO_SECTION_HEADER_BASICS",
                            defaultValue: "Basics",
                            comment: "The section header for basics in the student info page"
                        )
                    ) {
                        if !studentInfo.gender.isEmpty {
                            StudentInfoRowView(
                                image: "person.fill",
                                color: .orange,
                                name: String(
                                    localized: "STUDENT_INFO_GENDER_LABEL",
                                    defaultValue: "Gender",
                                    comment: "Label for student gender"
                                ),
                                value: studentInfo.gender
                            )
                        }
                        if !studentInfo.grade.isEmpty {
                            StudentInfoRowView(
                                image: "graduationcap.fill",
                                color: .green,
                                name: String(
                                    localized: "STUDENT_INFO_GRADE_LABEL",
                                    defaultValue: "Grade",
                                    comment: "Label for student grade"
                                ),
                                value: studentInfo.grade
                            )
                        }
                        if !studentInfo.birthDate.isEmpty {
                            StudentInfoRowView(
                                image: "calendar",
                                color: .red,
                                name: String(
                                    localized: "STUDENT_INFO_BIRTH_LABEL",
                                    defaultValue: "Birth Date",
                                    comment: "Label for student birth date"
                                ),
                                value: studentInfo.birthDate
                            )
                        }
                        if !studentInfo.address.isEmpty {
                            StudentInfoRowView(
                                image: "house.fill",
                                color: .blue,
                                name: String(
                                    localized: "STUDENT_INFO_ADDRESS_LABEL",
                                    defaultValue: "Address",
                                    comment: "Label for student address"
                                ),
                                value: studentInfo.address
                            )
                        }
                        if !studentInfo.email.isEmpty {
                            StudentInfoRowView(
                                image: "envelope.fill",
                                color: .blue,
                                name: String(
                                    localized: "STUDENT_INFO_EMAIL_LABEL",
                                    defaultValue: "Email",
                                    comment: "Label for student email"
                                ),
                                value: studentInfo.email.lowercased()
                            )
                            .contextMenu {
                                if let url = URL(string: "mailto:\(studentInfo.email)") {
                                    Link(
                                        String(
                                            localized: "EMAIL_BUTTON",
                                            defaultValue: "Email",
                                            comment: "Button to email"
                                        ),
                                        destination: url
                                    )
                                } else {
                                    Text("\(studentInfo.email)")
                                }
                            }
                        }
                        if !studentInfo.phone.isEmpty {
                            StudentInfoRowView(
                                image: "phone.fill",
                                color: .green,
                                name: String(
                                    localized: "STUDENT_INFO_PHONE_LABEL",
                                    defaultValue: "Phone",
                                    comment: "Label for student phone number"
                                ),
                                value: studentInfo.phone
                            )
                            .contextMenu {
                                if let url = URL(string: "tel:\(studentInfo.phone)") {
                                    Link(
                                        String(
                                            localized: "CALL_BUTTON",
                                            defaultValue: "Call",
                                            comment: "Button to call"
                                        ),
                                        destination: url
                                    )
                                } else {
                                    Text("\(studentInfo.phone)")
                                }
                            }
                        }
                    }
                    
                    if !studentInfo.emergencyContacts.isEmpty {
                        Section(
                            String(
                                localized: "STUDENT_INFO_SECTION_HEADER_EMERGENCY_CONTACTS",
                                defaultValue: "Emergency Contacts",
                                comment: "The section header for emergency contacts in the student info page"
                            )
                        ) {
                            EmergencyContactsView(info: studentInfo)
                        }
                    }
                    
                    if !studentInfo.dentist.name.isEmpty || !studentInfo.physician.name.isEmpty {
                        Section(
                            String(
                                localized: "STUDENT_INFO_SECTION_HEADER_DOCTORS",
                                defaultValue: "Doctors",
                                comment: "The section header for doctors in the student info page"
                            )
                        ) {
                            DoctorsView(info: studentInfo)
                        }
                    }
                    
                    if !studentInfo.userDefinedGroupBoxes.isEmpty {
                        Section(
                            String(
                                localized: "STUDENT_INFO_SECTION_HEADER_OTHER",
                                defaultValue: "Other",
                                comment: "The section header for other information in the student info page"
                            )
                        ) {
                            OtherInfoView(info: studentInfo)
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
            .navigationTitle(
                String(
                    localized: "STUDENT_INFO_NAV_TITLE",
                    defaultValue: "Me",
                    comment: "Navigation title for the student info page"
                )
            )
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(
                        String(
                            localized: "LOG_OUT_BUTTON_TEXT",
                            defaultValue: "Log Out"
                        )
                    ) {
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
