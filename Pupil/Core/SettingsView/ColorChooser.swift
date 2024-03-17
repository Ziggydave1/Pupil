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
    @State private var gradeColors: GradeColors = Defaults[.gradeColors]
    @State private var needsSaving: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Circle()
                    .stroke(gradeColors.defaultColor, lineWidth: 20)
                    .rotationEffect(.degrees(-90))
                    .padding(40)
                Group {
                    ColorPicker(String(localized: "COLOR_CHOOSER_DEFAULT_COLOR", defaultValue: "Default Color", comment: "The default color for grade colors"), selection: $gradeColors.defaultColor, supportsOpacity: false)
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
                        .onChange(of: stop) { stopChanged() }
                }
            }
        }
        .frame(maxWidth: 450)
        .padding()
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(String(localized: "GRADE_COLOR_CHOOSER_SAVE", defaultValue: "Save", comment: "Button to save changes to the grade colors")) {
                    needsSaving = false
                    Defaults[.gradeColors] = gradeColors
                    WidgetCenter.shared.reloadAllTimelines()
                }
                .tint(Defaults[.accentColor])
                .disabled(!needsSaving)
            }
            ToolbarItem(placement: .destructiveAction) {
                Button(String(localized: "GRADE_COLOR_CHOOSER_RESET", defaultValue: "Reset", comment: "Button to reset the grade colors to default"), role: .destructive) {
                    needsSaving = true
                    gradeColors = GradeColors.defaultTheme
                }
                .tint(.red)
            }
        }
        .navigationTitle(String(localized: "GRADE_COLOR_CHOOSER_NAV_TITLE", defaultValue: "Grade Colors", comment: "Navigation title for the grade color chooser page"))
    }
    
    func stopChanged() {
        withAnimation {
            gradeColors.stops.sort { $0.grade < $1.grade }
            needsSaving = true
        }
    }
}

#Preview("ColorChooser") {
    NavigationStack {
        ColorChooser()
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
            Text(stop.grade.gradeColorFormatted())
                .rotationEffect(.degrees(90))
                .rotationEffect(.degrees(-Double(stop.grade) * 360 / 100))
                .offset(x: -75 + width / 2)
                .frame(width: 100)
            ColorPicker(String(localized: "COLOR_CHOOSER_COLOR_STOP", defaultValue: "Color", comment: "One of the colors to choose for the grade colors"), selection: $stop.color, supportsOpacity: false)
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
                .onChanged { value in
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
                }
        )
        .rotationEffect(.degrees(-90))
    }
}
