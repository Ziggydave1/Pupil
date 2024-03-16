//
//  IDCardRowView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/4/23.
//

import SwiftUI
import SwiftVue

struct IDCardRowView: View {
    let info: StudentInfo
    var body: some View {
        HStack {
            if let data = Data(base64Encoded: info.base64Photo), let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.circle)
                    .frame(width: 60, height: 60)
            } else {
                Image(systemName: "person.circle.fill")
                    .font(.custom("", size: 50))
                    .foregroundColor(.blue)
            }
            VStack (alignment: .leading) {
                Text(info.formattedName)
                    .font(.title2)
                Text(String(localized: "ID_CARD_ROW_SUBTITLE", defaultValue: "View ID Card", comment: "Subtitle for the id card row in settings"))
                    .font(.footnote)
            }
        }
    }
}

#Preview("IDCardRowView") {
    IDCardRowView(info: StudentInfo.preview)
}
