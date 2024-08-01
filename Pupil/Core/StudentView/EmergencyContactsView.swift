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
            DisclosureGroup {
                if !contact.homePhone.isEmpty, let url = URL(string: "tel:\(contact.homePhone)") {
                    LabeledContent(
                        String(
                            localized: "EMERGENCY_CONTACT_HOME_PHONE_LABEL",
                            defaultValue: "Home",
                            comment: "The home phone label"
                        ),
                        value: String(
                            localized: "EMERGENCY_CONTACT_HOME_PHONE",
                            defaultValue: "\(contact.homePhone)",
                            comment: "The home phone number for the emergency contact"
                        )
                    )
                    .contextMenu {
                        Link(
                            String(
                                localized: "EMERGENCY_CONTACT_CALL_HOME_PHONE",
                                defaultValue: "Call",
                                comment: "Call the home phone number"
                            ),
                            destination: url
                        )
                    }
                }
                if !contact.workPhone.isEmpty, let url = URL(string: "tel:\(contact.workPhone)") {
                    LabeledContent(
                        String(
                            localized: "EMERGENCY_CONTACT_WORK_PHONE_LABEL",
                            defaultValue: "Work",
                            comment: "The work phone label"
                        ),
                        value: String(
                            localized: "EMERGENCY_CONTACT_WORK_PHONE",
                            defaultValue: "\(contact.workPhone)",
                            comment: "The work phone number for the emergency contact"
                        )
                    )
                    .contextMenu {
                        Link(
                            String(
                                localized: "EMERGENCY_CONTACT_CALL_WORK_PHONE",
                                defaultValue: "Call",
                                comment: "Call the work phone number"
                            ),
                            destination: url
                        )
                    }
                }
                if !contact.otherPhone.isEmpty, let url = URL(string: "tel:\(contact.otherPhone)") {
                    LabeledContent(
                        String(
                            localized: "EMERGENCY_CONTACT_OTHER_PHONE_LABEL",
                            defaultValue: "Other",
                            comment: "The other phone label"
                        ),
                        value: String(
                            localized: "EMERGENCY_CONTACT_OTHER_PHONE",
                            defaultValue: "\(contact.otherPhone)",
                            comment: "The other phone number for the emergency contact"
                        )
                    )
                    .contextMenu {
                        Link(
                            String(
                                localized: "EMERGENCY_CONTACT_CALL_OTHER_PHONE",
                                defaultValue: "Call",
                                comment: "Call the other phone number"
                            ),
                            destination: url
                        )
                    }
                }
                if !contact.mobilePhone.isEmpty, let url = URL(string: "tel:\(contact.mobilePhone)") {
                    LabeledContent(
                        String(
                            localized: "EMERGENCY_CONTACT_MOBILE_PHONE_LABEL",
                            defaultValue: "Mobile",
                            comment: "The mobile phone label"
                        ),
                        value: String(
                            localized: "EMERGENCY_CONTACT_MOBILE_PHONE",
                            defaultValue: "\(contact.mobilePhone)",
                            comment: "The mobile phone number for the emergency contact"
                        )
                    )
                    .contextMenu {
                        Link(
                            String(
                                localized: "EMERGENCY_CONTACT_CALL_MOBILE_PHONE",
                                defaultValue: "Call",
                                comment: "Call the mobile phone number"
                            ),
                            destination: url
                        )
                    }
                }
            } label: {
                StudentInfoRowView(
                    image: "staroflife.fill",
                    color: .red,
                    name: contact.relationship,
                    value: contact.name
                )
            }
        }
    }
}

#Preview("EmergencyContactsView") {
    EmergencyContactsView(info: StudentInfo.preview)
}
