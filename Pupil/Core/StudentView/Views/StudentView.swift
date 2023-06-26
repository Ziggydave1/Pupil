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
        NavigationView {
            ZStack {
                List {
                    if let studentInfo = vm.studentInfo {
                        Section {
                            NavigationLink {
                                IDCardView(info: studentInfo)
                            } label: {
                                HStack {
                                    if let data = Data(base64Encoded: studentInfo.base64Photo), let uiImage = UIImage(data: data) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 60, height: 60)
                                    } else {
                                        Image(systemName: "person.circle.fill")
                                            .font(.system(size: 50))
                                            .foregroundColor(.blue)
                                    }
                                    VStack (alignment: .leading) {
                                        Text(studentInfo.formattedName)
                                            .font(.title2)
                                        Text("View ID Card")
                                            .font(.footnote)
                                    }
                                }
                            }
                        }
                        
                        Section {
                            StudentInfoRowView(image: "person.fill", color: .orange, name: "Gender", value: studentInfo.gender)
                            StudentInfoRowView(image: "graduationcap.fill", color: .green, name: "Grade", value: studentInfo.grade)
                            StudentInfoRowView(image: "calendar", color: .red, name: "Birth Date", value: studentInfo.birthDate)
                            StudentInfoRowView(image: "house.fill", color: .blue, name: "Address", value: studentInfo.address)
                            StudentInfoRowView(image: "envelope.fill", color: .blue, name: "Email", value: studentInfo.email.lowercased())
                                .contextMenu {
                                    if let url = URL(string: "mailto:\(studentInfo.email)") {
                                        Link("Email", destination: url)
                                    } else {
                                        Text("\(studentInfo.phone)")
                                    }
                                }
                            StudentInfoRowView(image: "phone.fill", color: .green, name: "Phone", value: studentInfo.phone)
                                .contextMenu {
                                    if let url = URL(string: "tel:\(studentInfo.phone)") {
                                        Link("Call", destination: url)
                                    } else {
                                        Text("\(studentInfo.phone)")
                                    }
                                }
                        }
                        
                        Section {
                            NavigationLink {
                                List {
                                    ForEach(studentInfo.emergencyContacts) { contact in
                                        StudentInfoRowView(image: "person.fill", color: .red, name: contact.relationship, value: contact.name)
                                            .contextMenu {
                                                if contact.homePhone.count != 0, let url = URL(string: "tel:\(contact.homePhone)") {
                                                    Link("\(contact.homePhone) - Home", destination: url)
                                                }
                                                if contact.workPhone.count != 0, let url = URL(string: "tel:\(contact.workPhone)") {
                                                    Link("\(contact.workPhone) - Work", destination: url)
                                                }
                                                if contact.otherPhone.count != 0, let url = URL(string: "tel:\(contact.otherPhone)") {
                                                    Link("\(contact.otherPhone) - Other", destination: url)
                                                }
                                                if contact.mobilePhone.count != 0, let url = URL(string: "tel:\(contact.mobilePhone)") {
                                                    Link("\(contact.mobilePhone) - Mobile", destination: url)
                                                }
                                            }
                                    }
                                }
                                .navigationTitle("Emergency Contacts")
                                .navigationBarTitleDisplayMode(.inline)
                            } label: {
                                StudentInfoRowView(image: "exclamationmark.shield.fill", color: .red, name: "Emergency Contacts")
                            }
                            
                            NavigationLink {
                                List {
                                    StudentInfoRowView(image: "facemask.fill", color: .blue, name: "Physician", value: studentInfo.physician.name)
                                        .contextMenu {
                                            Text(studentInfo.physician.hospital)
                                            if let url = URL(string: "tel:\(studentInfo.physician.phone)\(studentInfo.physician.extn.count != 0 ? studentInfo.physician.extn : "")") {
                                                Link("\(studentInfo.physician.phone)\(studentInfo.physician.extn.count != 0 ? studentInfo.physician.extn : "")", destination: url)
                                            }
                                        }
                                    StudentInfoRowView(image: "facemask.fill", color: .blue, name: "Dentist", value: studentInfo.dentist.name)
                                        .contextMenu {
                                            Text(studentInfo.dentist.office)
                                            if let url = URL(string: "tel:\(studentInfo.dentist.phone)\(studentInfo.dentist.extn.count != 0 ? studentInfo.dentist.extn : "")") {
                                                Link("\(studentInfo.dentist.phone)\(studentInfo.dentist.extn.count != 0 ? studentInfo.dentist.extn : "")", destination: url)
                                            }
                                        }
                                }
                                .navigationTitle("Doctors")
                                .navigationBarTitleDisplayMode(.inline)
                            } label: {
                                StudentInfoRowView(image: "staroflife.fill", color: .blue, name: "Doctors")
                            }
                            
                            NavigationLink {
                                List {
                                    ForEach(studentInfo.userDefinedGroupBoxes) { box in
                                        Section {
                                            ForEach(box.userDefinedItems) { item in
                                                StudentInfoRowView(image: "person.fill", color: .green, name: item.itemLabel, value: item.value)
                                            }
                                        }
                                    }
                                }
                                .navigationTitle("Other")
                                .navigationBarTitleDisplayMode(.inline)
                            } label: {
                                StudentInfoRowView(image: "person.crop.circle.badge.fill", color: .orange, name: "Other")
                            }
                            
                        }
                    } else {
                        Spacer()
                            .listRowBackground(Color.clear)
                    }
                    
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Student Info")
                .refreshable {
                    if !vm.loading {
                        vm.refresh()
                    }
                }
                
                if vm.loading {
                    ProgressView()
                        .tint(.gray)
                }
            }
            .withLogout(logout)
        }
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView()
            .environmentObject(StudentViewModel(credentials: dev.credentials, isPreview: true))
    }
}
