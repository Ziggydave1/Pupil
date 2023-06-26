//
//  PupilWidgetBundle.swift
//  PupilWidget
//
//  Created by Evan Kaneshige on 3/26/23.
//

import WidgetKit
import SwiftUI
import Defaults

@main
struct PupilWidgetBundle: WidgetBundle {
    var body: some Widget {
        CourseWidget()
        GradebookWidget()
    }
}
