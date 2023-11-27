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
