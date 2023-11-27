//
//  PupilApp.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/2/22.
//

import SwiftUI

@main
struct PupilApp: App {
    private let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            PupilView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
