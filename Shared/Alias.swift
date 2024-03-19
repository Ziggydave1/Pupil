//
//  Alias.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/17/24.
//
//

import Foundation
import SwiftData


@Model public class Alias {
    var icon: String
    @Attribute(.unique) var name: String
    @Relationship(deleteRule: .cascade) var links: [AliasLink]?
    
    public init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
}