//
//  DotProgressView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 11/26/23.
//

import SwiftUI

struct Dot: View {
    var y: CGFloat
    
    var body: some View {
        Circle()
            .frame(width: 8, height: 8, alignment: .center)
            .opacity(y == 0 ? 0.1 : 1)
            .scaleEffect(y)
            .foregroundColor(.white)
    }
}

struct DotProgressView: View {
    @State private var y: CGFloat = 0
    
    var body: some View {
        HStack{
            Dot(y: y)
                .animation(.easeInOut(duration: 0.5).repeatForever().delay(0), value: y)
            Dot(y: y)
                .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.2), value: y)
            Dot(y: y)
                .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.4), value: y)
        }
        .onAppear{y = 1.2}
    }
}

#Preview("DotProgressView") {
    DotProgressView()
}
