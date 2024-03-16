//
//  Double.swift
//  Pupil
//
//  Created by Evan Kaneshige on 11/13/23.
//

import Foundation

extension Double {
    func rawScoreFormatted() -> String { self.formatted(.percent.scale(1).precision(.fractionLength(0...2))) }
    
    func numberFormatted() -> String { self.formatted(.number.precision(.fractionLength(2))) }
    
    func percentFormatted() -> String { self.formatted(.percent.precision(.fractionLength(0...2))) }
    
    func gradeColorFormatted() -> String { self.formatted(.number.precision(.fractionLength(0))) }
}
