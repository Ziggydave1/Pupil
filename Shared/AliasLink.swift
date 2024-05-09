//
//  AliasLink.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/17/24.
//
//

import Foundation
import SwiftData


@Model class AliasLink {
    @Attribute(.unique) var key: String
    var value: Alias?
    
    init(key: String, value: Alias) {
        self.key = key
        self.value = value
    }
}
