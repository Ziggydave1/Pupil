//
//  GradeColors.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/15/23.
//

import SwiftUI
import Defaults

struct GradeColors: Codable, Defaults.Serializable {
    var stops: [GradeColorStop]
    var defaultColor: Color
    
    init() {
        self.stops = []
        self.defaultColor = .gray
    }
    
    static var defaultTheme: GradeColors {
        GradeColors(
            stops: [
                GradeColorStop(grade: 0, .red),
                GradeColorStop(grade: 60, .orange),
                GradeColorStop(grade: 70, .yellow),
                GradeColorStop(grade: 80, .cyan),
                GradeColorStop(grade: 90, .green)
            ]
        )
    }
    
    init(stops: [GradeColorStop], default color: Color = .gray) {
        self.stops = stops
        defaultColor = color
        
    }
    
    mutating func addStop(grade: Double, color: Color) {
        stops.append(GradeColorStop(grade: grade, color))
        stops.sort()
    }
    
    mutating func addStop(_ stop: GradeColorStop) {
        stops.append(stop)
        stops.sort()
    }
    
    func color(for rawScore: String?, and scoreString: String?) -> Color {
        if scoreString == "N/A" || scoreString == "Not Graded" {
            return .gray
        }
        var currentColor = Color.gray
        guard let rawScore, let grade = Double(rawScore) else {
            return .gray
        }
        stops.forEach { stop in
            if grade >= stop.grade {
                currentColor = stop.color
            }
        }
        return currentColor
    }
}

struct GradeColorStop: Codable, Identifiable, Comparable {
    var id: UUID
    var grade: Double
    var color: Color
    
    init(grade: Double, _ color: Color) {
        self.id = UUID()
        self.grade = grade
        self.color = color
    }
    
    static func <(lhs: GradeColorStop, rhs: GradeColorStop) -> Bool {
        return lhs.grade < rhs.grade
    }
    
    static func >(lhs: GradeColorStop, rhs: GradeColorStop) -> Bool {
        return lhs.grade > rhs.grade
    }
    
    static func <=(lhs: GradeColorStop, rhs: GradeColorStop) -> Bool {
        return lhs.grade <= rhs.grade
    }
    
    static func >=(lhs: GradeColorStop, rhs: GradeColorStop) -> Bool {
        return lhs.grade >= rhs.grade
    }
    
    static func ==(lhs: GradeColorStop, rhs: GradeColorStop) -> Bool {
        return lhs.grade == rhs.grade
    }
}
