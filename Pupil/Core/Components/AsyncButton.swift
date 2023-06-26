//
//  AsyncButton.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/13/23.
//

import SwiftUI
import Defaults

struct AsyncButton: View {
    @Default(.accentColor) var accentColor
    var action: () async throws -> Void
    
    var text: String
    var disabled: Bool
    
    @Binding var isPerformingTask: Bool
    
    var body: some View {
        Button(
            action: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                    isPerformingTask = true
                }
                Task {
                    try await action()
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                        isPerformingTask = false
                    }
                }
            },
            label: {
                HStack(spacing: 20) {
                    if !isPerformingTask {
                        Text(text)
                            .fontWeight(.semibold)
                    }
                    
                    if isPerformingTask {
                        DotProgressView()
                    }
                }
            }
        )
        .foregroundColor(.white)
        .opacity(isPerformingTask ? 0.5 : 1)
        .padding(15)
        .background(disabled ? Color.gray : (isPerformingTask ? accentColor.opacity(0.8) : accentColor))
        .disabled(isPerformingTask || disabled)
        .cornerRadius(10.0)
    }
    
    func trigger() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
            isPerformingTask = true
        }
        Task {
            try await action()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                    isPerformingTask = false
                    
                }
            }
        }
    }
}

struct AsyncButton_Previews: PreviewProvider {
    static var previews: some View {
        AsyncButton(action: {
            
        }, text: "Hello", disabled: false, isPerformingTask: .constant(true))
    }
}

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
