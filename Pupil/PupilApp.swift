//
//  PupilApp.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/2/22.
//

import SwiftUI
import SwiftData

@main
struct PupilApp: App {
    var body: some Scene {
        WindowGroup {
            if let container {
                PupilView()
                    .modelContainer(container)
            } else {
                PupilView()
                    .modelContainer(for: [AliasLink.self, Alias.self])
            }
        }
    }
    
    private var container: ModelContainer? {
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: App_Group) else { return nil }
        
        let storeURL = containerURL.appending(path: "PupilStorage.sqlite")
        let config = ModelConfiguration(url: storeURL)
        
        return try? ModelContainer(for: AliasLink.self, Alias.self, configurations: config)
    }
}
