//
//  AssignmentRowView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/15/23.
//

import SwiftUI
import SwiftVue

struct AssignmentRowView: View {
    var assignment: Assignment
    var body: some View {
        HStack {
            CircularProgressView(progress: assignment.points.pointsToPercentage(), lineWidth: 4)
                .frame(width: 25)
            VStack(alignment: .leading) {
                Text(assignment.name.formattedRight())
                    .font(.headline)
                Text(assignment.points)
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            .padding(.horizontal, 8)
            Spacer()
        }
    }
}

struct AssignmentRowView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentRowView(assignment: dev.assignment)
    }
}
