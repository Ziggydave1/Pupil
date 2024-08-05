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
        ForEach(info.userDefinedGroupBoxes.flatMap(\.userDefinedItems)) { item in
            StudentInfoRowView(
                image: "tag.fill",
                color: .orange,
                name: item.itemLabel,
                value: item.value
            )
        }
    }
}

#Preview("OtherInfoView") {
    OtherInfoView(info: StudentInfo.preview)
}
