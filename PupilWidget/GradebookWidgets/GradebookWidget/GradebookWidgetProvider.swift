//
//  GradebookWidgetProvider.swift
//  PupilWidgetExtension
//
//  Created by Evan Kaneshige on 3/26/23.
//

import SwiftVue
import WidgetKit
import Intents
import Defaults
import KeychainAccess

struct GradebookWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> GradebookWidgetEntry {
        GradebookWidgetEntry(date: Date(), grades: PreviewData.instance.multiMarkGradebook, error: nil)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (GradebookWidgetEntry) -> ()) {
        completion(GradebookWidgetEntry(date: Date(), grades: PreviewData.instance.multiMarkGradebook, error: nil))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<GradebookWidgetEntry>) -> ()) {
        guard Defaults[.useBiometrics] else {
            let entry = GradebookWidgetEntry(date: Date(), grades: nil, error: "Enable save login in Pupil to use this widget.")
            completion(Timeline(entries: [entry], policy: .never))
            return
        }

        guard let district = Defaults[.district]?.url else {
            let entry = GradebookWidgetEntry(date: Date(), grades: nil, error: "Error loading district URL.")
            completion(Timeline(entries: [entry], policy: .never))
            return
        }

        let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)

        guard let password = keychain["password"] else {
            let entry = GradebookWidgetEntry(date: Date(), grades: nil, error: "Error retrieving user password.")
            completion(Timeline(entries: [entry], policy: .never))
            return
        }

        let studentVue = StudentVue(username: Defaults[.username], password: password, districtURL: district)

        Task {
            let result = await studentVue.getGradebook()
            switch result {
            case .success(let success):
                let entry = GradebookWidgetEntry(date: Date(), grades: success, error: nil)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*60)))
                completion(timeline)
            case .failure(let failure):
                let entry = GradebookWidgetEntry(date: Date(), grades: nil, error: failure.localizedDescription)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*60)))
                completion(timeline)
            }
        }
    }
}
