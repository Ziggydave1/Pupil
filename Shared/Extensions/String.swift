//
//  String.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/27/23.
//

import Foundation

extension String {
    func pointsToPercentage() -> Double {
        let noSpaces = self.replacingOccurrences(of: " ", with: "")
        let parts = noSpaces.split(separator: "/")
        if parts.count == 2 {
            return 100*(Double(parts[0]) ?? 0)/(Double(parts[1]) ?? 0)
        }
        return 0
    }
    
    func formattedRight() -> String {
        return self.replacingOccurrences(of: "&quot;", with: "\"")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&#xD", with: "")
            .replacingOccurrences(of: "&#xA", with: "")
            .replacingOccurrences(of: "&amp;", with: "&")
    }

}
