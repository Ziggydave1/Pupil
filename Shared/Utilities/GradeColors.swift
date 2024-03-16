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
    
    static let defaultTheme: GradeColors = GradeColors(
        stops: [
            GradeColorStop(grade: 0, color: .red),
            GradeColorStop(grade: 60, color: .orange),
            GradeColorStop(grade: 70, color: .yellow),
            GradeColorStop(grade: 80, color: .cyan),
            GradeColorStop(grade: 90, color: .green)
        ]
    )
    
    init(stops: [GradeColorStop], default color: Color = .gray) {
        self.stops = stops
        defaultColor = color
        
    }
    
    mutating func add(stop: GradeColorStop) {
        stops.append(stop)
        stops.sort { $0.grade < $1.grade }
    }
    
    func color(for rawScore: Double?, and scoreString: String?) -> Color {
        if scoreString == "N/A" || scoreString == "Not Graded" {
            return .gray
        }
        var currentColor = Color.gray
        guard let rawScore else {
            return .gray
        }
        
        stops.forEach { stop in
            if rawScore >= stop.grade {
                currentColor = stop.color
            }
        }
        return currentColor
    }
}

struct GradeColorStop: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var grade: Double
    var color: Color
    
    static func ==(lhs: GradeColorStop, rhs: GradeColorStop) -> Bool {
        return lhs.grade == rhs.grade && lhs.color == rhs.color
    }
}
