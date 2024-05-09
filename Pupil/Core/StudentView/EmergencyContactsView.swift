//
//  EmergencyContactsView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/4/23.
//

import SwiftUI
import SwiftVue

struct EmergencyContactsView: View {
    let info: StudentInfo
    
    var body: some View {
        ForEach(info.emergencyContacts) { contact in
            StudentInfoRowView(image: "person.fill", color: .red, name: contact.relationship, value: contact.name)
                .contextMenu {
                    if !contact.homePhone.isEmpty, let url = URL(string: "tel:\(contact.homePhone)") {
                        Link(String(localized: "EMERGENCY_CONTACT_HOME_PHONE", defaultValue: "\(contact.homePhone) - Home", comment: "The home phone number for the emergency contact"), destination: url)
                    }
                    if !contact.workPhone.isEmpty, let url = URL(string: "tel:\(contact.workPhone)") {
                        Link(String(localized: "EMERGENCY_CONTACT_WORK_PHONE", defaultValue: "\(contact.workPhone) - Work", comment: "The work phone number for the emergency contact"), destination: url)
                    }
                    if !contact.otherPhone.isEmpty, let url = URL(string: "tel:\(contact.otherPhone)") {
                        Link(String(localized: "EMERGENCY_CONTACT_OTHER_PHONE", defaultValue: "\(contact.otherPhone) - Other", comment: "The other phone number for the emergency contact"), destination: url)
                    }
                    if !contact.mobilePhone.isEmpty, let url = URL(string: "tel:\(contact.mobilePhone)") {
                        Link(String(localized: "EMERGENCY_CONTACT_MOBILE_PHONE", defaultValue: "\(contact.mobilePhone) - Mobile", comment: "The mobile phone number for the emergency contact"), destination: url)
                    }
                }
        }
    }
}

#Preview("EmergencyContactsView") {
    EmergencyContactsView(info: StudentInfo.preview)
}
