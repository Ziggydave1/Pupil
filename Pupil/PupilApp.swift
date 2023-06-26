//
//  PupilApp.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/2/22.
//

import SwiftUI
import Defaults

@main
struct PupilApp: App {
    @Default(.accentColor) var accentColor
    let persistenceController = PersistenceController.shared
    @StateObject private var vm = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(vm)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tint(accentColor)
        }
    }
}
