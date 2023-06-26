//
//  CourseWidgetEntry.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/26/23.
//

import Foundation
import WidgetKit
import SwiftVue


struct CourseWidgetEntry: TimelineEntry {
    let date: Date
    let configuration: CourseConfigurationIntent
    let course: Course?
    let error: String?
}
