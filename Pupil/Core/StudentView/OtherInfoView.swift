//
//  OtherInfoView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/4/23.
//

import SwiftUI
import SwiftVue

struct OtherInfoView: View {
    let info: StudentInfo
    var body: some View {
        ForEach(info.userDefinedGroupBoxes) { box in
            Section {
                ForEach(box.userDefinedItems) { item in
                    StudentInfoRowView(image: "person.fill", color: .orange, name: item.itemLabel, value: item.value)
                }
            }
        }
    }
}

#Preview("OtherInfoView") {
    OtherInfoView(info: StudentInfo.preview)
}
