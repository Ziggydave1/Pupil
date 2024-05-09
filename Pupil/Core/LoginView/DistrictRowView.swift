//
//  DistrictRowView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/5/22.
//

import SwiftUI
import SwiftVue
import Defaults

struct DistrictRowView: View {
    @Default(.accentColor) private var accentColor
    let district: DistrictInfo
    
    var body: some View {
        HStack {
            Image(systemName: "building.2.fill")
                .foregroundColor(accentColor)
                .padding(.trailing, 5)
            VStack(alignment: .leading) {
                Text(district.name)
                Text(district.url)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 5)
        .foregroundColor(.primary)
    }
}

#Preview("DistrictRowView") {
    List {
        DistrictRowView(district: DistrictInfo.preview)
    }
    .listStyle(.inset)
}
