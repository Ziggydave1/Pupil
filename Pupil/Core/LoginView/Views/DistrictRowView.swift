//
//  DistrictRowView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/5/22.
//

import SwiftUI
import SwiftVue

struct DistrictRowView: View {
    let district: DistrictInfo
    var body: some View {
        HStack {
            Image(systemName: "building.2.fill")
                .foregroundColor(.blue)
                .padding(.trailing, 5)
            VStack(alignment: .leading) {
                Text(district.name)
                Text(district.url)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.vertical, 5)
        .foregroundColor(.primary)
    }
}

struct DistrictRowView_Previews: PreviewProvider {
    static var previews: some View {
        DistrictRowView(district: dev.districtInfo)
    }
}
