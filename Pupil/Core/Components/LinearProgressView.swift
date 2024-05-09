//
//  LinearProgressView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/3/23.
//

import SwiftUI

struct LinearProgressView: View {
    let progress: CGFloat
    let lineWidth: CGFloat
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            let width = max(0, min(geometry.size.width * progress, geometry.size.width))
            ZStack(alignment: .leading) {
                Capsule()
                    .foregroundColor(.init(.systemGray5))
                Capsule()
                    .foregroundColor(color)
                    .frame(width: width)
            }
        }
        .frame(height: lineWidth)
    }
}

#Preview("LinearProgressView") {
    LinearProgressView(progress: 0.7, lineWidth: 10, color: .blue)
}
