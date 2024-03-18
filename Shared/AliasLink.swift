//
//  AliasLink.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/17/24.
//
//

import Foundation
import SwiftData


@Model public class AliasLink {
    @Attribute(.unique) var key: String
    var value: Alias?
    
    public init(key: String) {
        self.key = key
    }
}
