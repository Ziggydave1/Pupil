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
    func placeholder(in context: Context) -> GradebookWidgetEntry { previewEntry }
    
    func getSnapshot(in context: Context, completion: @escaping (GradebookWidgetEntry) -> ()) {
        if context.isPreview {
            completion(previewEntry)
        } else {
            Task {
                do {
                    let gradebook = try await getGradebook()
                    let entry = GradebookWidgetEntry(date: Date(), result: .success(gradebook))
                    completion(entry)
                } catch {
                    let entry = GradebookWidgetEntry(date: Date(), result: .failure(error))
                    completion(entry)
                }
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<GradebookWidgetEntry>) -> ()) {
        Task {
            do {
                let gradebook = try await getGradebook()
                let entry = GradebookWidgetEntry(date: Date(), result: .success(gradebook))
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*60)))
                completion(timeline)
            } catch {
                let entry = GradebookWidgetEntry(date: Date(), result: .failure(error))
                let timeline = Timeline(entries: [entry], policy: .never)
                completion(timeline)
            }
        }
    }
    
    func getGradebook() async throws -> Gradebook {
        guard Defaults[.useBiometrics] else {
            throw PupilWidgetError.saveLoginNotEnabled
        }
        guard let district = Defaults[.district]?.url else {
            throw PupilWidgetError.invalidDistrictURL
        }
        
        let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)
        
        guard let password = keychain["password"] else {
            throw PupilWidgetError.unableToGetPassword
        }
        
        let credentials = Credentials(username: Defaults[.username], password: password, districtURL: district)
        let studentVue = StudentVue(credentials: credentials)
        
        return try await studentVue.getGradebook()
    }
    
    var previewEntry: GradebookWidgetEntry {
        GradebookWidgetEntry(date: Date(), result: .success(Gradebook.preview))
    }
}
