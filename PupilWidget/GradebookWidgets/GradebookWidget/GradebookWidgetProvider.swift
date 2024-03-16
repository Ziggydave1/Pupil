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
        GradebookWidgetEntry(date: Date(), grades: Gradebook.preview, error: nil)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (GradebookWidgetEntry) -> ()) {
        completion(GradebookWidgetEntry(date: Date(), grades: Gradebook.preview, error: nil))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<GradebookWidgetEntry>) -> ()) {
        guard Defaults[.useBiometrics] else {
            let entry = GradebookWidgetEntry(date: Date(), grades: nil, error: String(localized: "WIDGET_ERROR_LOGIN_NOT_SAVED", defaultValue: "Enable save login within Pupil to use this widget.", comment: "The user credentials are not saved, which the widget requires to work"))
            completion(Timeline(entries: [entry], policy: .never))
            return
        }

        guard let district = Defaults[.district]?.url else {
            let entry = GradebookWidgetEntry(date: Date(), grades: nil, error: String(localized: "WIDGET_ERROR_DISTRICT_URL_INVALID", defaultValue: "Error loading district URL.\nPlease find your district again within Pupil.", comment: "The users district url is invalid"))
            completion(Timeline(entries: [entry], policy: .never))
            return
        }

        let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)

        guard let password = keychain["password"] else {
            let entry = GradebookWidgetEntry(date: Date(), grades: nil, error: String(localized: "WIDGET_ERROR_UNABLE_TO_GET_PASSWORD", defaultValue: "Error retrieving user password.\nTry logging into the app.", comment: "The user password was unable to be retrieved"))
            completion(Timeline(entries: [entry], policy: .never))
            return
        }
        
        let credentials = Credentials(username: Defaults[.username], password: password, districtURL: district)
        let studentVue = StudentVue(credentials: credentials)

        Task {
            do {
                let result = try await studentVue.getGradebook()
                let entry = GradebookWidgetEntry(date: Date(), grades: result, error: nil)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*60)))
                completion(timeline)
            } catch {
                let entry = GradebookWidgetEntry(date: Date(), grades: nil, error: error.localizedDescription)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*60)))
                completion(timeline)
            }
        }
    }
}
