//
//  CircularProgressView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/15/23.
//

import SwiftUI
import Defaults

struct CircularProgressView: View {
    @Default(.gradeColors) var gradeColors
    let progress: CGFloat
    let lineWidth: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: (progress / 100))
                .stroke(gradeColors.color(for: progress, and: nil), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(270))
        }
    }
}

#Preview("CircularProgressView") {
    CircularProgressView(progress: 70, lineWidth: 10)
        .frame(width: 60, height: 60)
}
