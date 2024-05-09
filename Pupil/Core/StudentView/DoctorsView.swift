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
            StudentInfoRowView(image: "facemask.fill", color: .blue, name: String(localized: "DOCTORS_PHYSICAIN_LABEL", defaultValue: "Physician", comment: "Physician label for the doctors page"), value: info.physician.name)
                .contextMenu {
                    Text(info.physician.hospital)
                    if let url = URL(string: "tel:\(info.physician.phone)\(info.physician.extn.count != 0 ? info.physician.extn : "")") {
                        Link("\(info.physician.phone)\(info.physician.extn.count != 0 ? info.physician.extn : "")", destination: url)
                    }
                }
        }
        if !info.dentist.name.isEmpty {
            StudentInfoRowView(image: "facemask.fill", color: .blue, name: String(localized: "DOCTORS_DENTIST_LABEL", defaultValue: "Dentist", comment: "Dentist label for the doctors page"), value: info.dentist.name)
                .contextMenu {
                    Text(info.dentist.office)
                    if let url = URL(string: "tel:\(info.dentist.phone)\(info.dentist.extn.count != 0 ? info.dentist.extn : "")") {
                        Link("\(info.dentist.phone)\(info.dentist.extn.count != 0 ? info.dentist.extn : "")", destination: url)
                    }
                }
        }
    }
}

#Preview("DoctorsView") {
    DoctorsView(info: StudentInfo.preview)
}
