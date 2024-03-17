//
//  GradebookWidgetEntry.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/26/23.
//

import Foundation
import WidgetKit
import SwiftVue

struct GradebookWidgetEntry: TimelineEntry {
    let date: Date
    let result: Result<Gradebook, Error>
}
