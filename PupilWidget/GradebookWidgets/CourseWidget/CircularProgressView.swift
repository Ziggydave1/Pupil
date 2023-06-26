//
//  CircularProgressView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/26/23.
//

import SwiftUI
import WidgetKit

struct CircularProgressView: View {
    let progress: Double
    let lineWidth: CGFloat
    let color: Color
    
    var body: some View {
        Circle()
            .trim(from: 0, to: (progress / 100))
            .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .rotationEffect(.degrees(270))
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 90, lineWidth: 10, color: .green)
            .frame(width: 60, height: 60)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
