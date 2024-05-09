//
//  StudentInfoRowView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/19/23.
//

import SwiftUI

struct StudentInfoRowView: View {
    let image: String
    var color: Color
    let name: String
    let value: String?
    
    init(image: String, color: Color, name: String, value: String? = nil) {
        self.image = image
        self.color = color
        self.name = name
        self.value = value
    }
    
    var body: some View {
        HStack {
            IconInSquare(color: color, image: image)
            Text(name)
            
            Spacer()
            
            Text(value?.formattedRight() ?? "")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview("StudentInfoRowView") {
    StudentInfoRowView(image: "facemask.fill", color: .blue, name: "Dentist", value: "Ashlee Aragon")
}
