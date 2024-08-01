//
//  DoctorsView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/4/23.
//

import SwiftUI
import SwiftVue

struct DoctorsView: View {
    let info: StudentInfo
    var body: some View {
        if !info.physician.name.isEmpty {
            DisclosureGroup {
                LabeledContent(
                    String(
                        localized: "PHYSICIAN_HOSPITAL_NAME",
                        defaultValue: "\(info.physician.hospital)",
                        comment: "The physician's hospital name"
                    ),
                    value: String(
                        localized: "PHYSICIAN_PHONE_NUMBER",
                        defaultValue: "\(info.physician.phone)\(info.physician.extn.count != 0 ? info.physician.extn : "")",
                        comment: "The phone number for the physician"
                    )
                )
                .contextMenu {
                    if let url = URL(string: "tel:\(info.physician.phone)\(info.physician.extn.count != 0 ? info.physician.extn : "")") {
                        Link(
                            String(
                                localized: "PHYSICIAN_CALL_PHONE",
                                defaultValue: "Call",
                                comment: "Call the physician's phone number"
                            ),
                            destination: url
                        )
                    }
                    
                }
            } label: {
                StudentInfoRowView(
                    image: "facemask.fill",
                    color: .blue,
                    name: String(
                        localized: "DOCTORS_PHYSICIAN_LABEL",
                        defaultValue: "Physician",
                        comment: "Physician label for the doctors page"
                    ),
                    value: info.physician.name
                )
            }
        }
        
        if !info.dentist.name.isEmpty {
            DisclosureGroup {
                LabeledContent(
                    String(
                        localized: "DENTIST_OFFICE_NAME",
                        defaultValue: "\(info.dentist.office)",
                        comment: "The dentist's office name"
                    ),
                    value: String(
                        localized: "DENTIST_PHONE_NUMBER",
                        defaultValue: "\(info.dentist.phone)\(info.dentist.extn.count != 0 ? info.dentist.extn : "")",
                        comment: "The phone number for the dentist"
                    )
                )
                .contextMenu {
                    if let url = URL(string: "tel:\(info.dentist.phone)\(info.dentist.extn.count != 0 ? info.dentist.extn : "")") {
                        Link(
                            String(
                                localized: "DENTIST_CALL_PHONE",
                                defaultValue: "Call",
                                comment: "Call the dentist's phone number"
                            ),
                            destination: url
                        )
                    }
                    
                }
            } label: {
                StudentInfoRowView(
                    image: "facemask.fill",
                    color: .blue,
                    name: String(
                        localized: "DOCTORS_DENTIST_LABEL",
                        defaultValue: "Dentist",
                        comment: "Dentist label for the doctors page"
                    ),
                    value: info.dentist.name
                )
            }
        }
    }
}

#Preview("DoctorsView") {
    DoctorsView(info: StudentInfo.preview)
}
