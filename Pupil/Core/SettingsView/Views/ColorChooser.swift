//
//  ColorChooser.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/6/23.
//

import SwiftUI
import Defaults
import WidgetKit

struct ColorChooser: View {
    @State private var gradeColors: GradeColors
    @State private var needsSaving: Bool = false
    init() {
        self._gradeColors = State(initialValue: Defaults[.gradeColors])
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Circle()
                    .stroke(gradeColors.defaultColor, lineWidth: 20)
                    .rotationEffect(.degrees(-90))
                    .padding(40)
                Group {
                    ColorPicker(selection: $gradeColors.defaultColor, supportsOpacity: false, label: {
                        EmptyView()
                    })
                    .labelsHidden()
                    .offset(x: proxy.size.width / 2)
                    Rectangle()
                        .frame(width: 4, height: 30)
                        .rotationEffect(.degrees(-90))
                        .offset(x: -40 + proxy.size.width / 2)
                        .zIndex(.infinity)
                }
                .rotationEffect(.degrees(-90))
                ForEach($gradeColors.stops) { $stop in
                    let width = proxy.size.width
                    Child(stop: $stop, width: width)
                        .onChange(of: gradeColors.stops, perform: { value in
                            gradeColors.stops.sort()
                            needsSaving = true
                        })
                }
                Button {
                    gradeColors = GradeColors.defaultTheme
                    needsSaving = true
                } label: {
                    Text("Reset")
                        .foregroundColor(.primary)
                        .padding(25)
                        .background(Color.init(.systemGray5), in: Circle())
                }
            }
        }
        .frame(maxWidth: 450)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    needsSaving = false
                    Defaults[.gradeColors] = gradeColors
                    WidgetCenter.shared.reloadAllTimelines()
                } label: {
                    Text("Save")
                        .disabled(!needsSaving)
                        .tint(needsSaving ? Defaults[.accentColor] : .gray)
                }
            }
        }
    }
}

struct ColorChooser_Previews: PreviewProvider {
    static var previews: some View {
        ColorChooser()
            .padding()
    }
}

struct Child: View {
    @Binding var stop: GradeColorStop
    var width: CGFloat
    var body: some View {
        Circle()
            .trim(from: stop.grade / 100, to: 1.0)
            .stroke(stop.color, lineWidth: 20)
            .rotationEffect(.degrees(-90))
            .padding(40)
        Group {
            Text("\(Int(stop.grade))")
                .rotationEffect(.degrees(90))
                .rotationEffect(.degrees(-Double(stop.grade) * 360 / 100))
                .offset(x: -75 + width / 2)
            ColorPicker(selection: $stop.color, supportsOpacity: false, label: {
                EmptyView()
            })
            .labelsHidden()
            .offset(x: width / 2)
            Rectangle()
                .frame(width: 4, height: 30)
                .rotationEffect(.degrees(-90))
                .offset(x: -40 + width / 2)
                .zIndex(.infinity)
        }
        .rotationEffect(.degrees(Double(stop.grade) * 360 / 100))
        .gesture(
            DragGesture()
                .onChanged({ value in
                    let vector = CGVector(dx: value.location.x, dy: value.location.y)
                    let radians = atan2(vector.dy, vector.dx)
                    
                    var angle = (radians * 180 / .pi)
                    if angle < 0 {
                        angle = 360 + angle
                    }
                    
                    let progress = angle / 360
                    let rounded = round(progress * 100)
                    if rounded == 100 {
                        stop.grade = 0
                    } else {
                        stop.grade = rounded
                    }
                })
        )
        .rotationEffect(.degrees(-90))
    }
}
