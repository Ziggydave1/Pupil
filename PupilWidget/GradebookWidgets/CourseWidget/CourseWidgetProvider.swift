//
//  CourseWidgetProvider.swift
//  PupilWidgetExtension
//
//  Created by Evan Kaneshige on 3/26/23.
//

import SwiftVue
import WidgetKit
import Intents
import Defaults
import KeychainAccess

struct CourseWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> CourseWidgetEntry {
        CourseWidgetEntry(date: Date(), configuration: CourseConfigurationIntent(), course: Course.preview, error: nil)
    }
    
    func getSnapshot(for configuration: CourseConfigurationIntent, in context: Context, completion: @escaping (CourseWidgetEntry) -> ()) {
        completion(CourseWidgetEntry(date: Date(), configuration: configuration, course: Course.preview, error: nil))
    }
    
    func getTimeline(for configuration: CourseConfigurationIntent, in context: Context, completion: @escaping (Timeline<CourseWidgetEntry>) -> ()) {
        guard Defaults[.useBiometrics] else {
            let entry = CourseWidgetEntry(date: Date(), configuration: configuration, course: nil, error: String(localized: "WIDGET_ERROR_LOGIN_NOT_SAVED", defaultValue: "Enable save login within Pupil to use this widget."))
            completion(Timeline(entries: [entry], policy: .never))
            return
        }
        
        guard let district = Defaults[.district]?.url else {
            let entry = CourseWidgetEntry(date: Date(), configuration: configuration, course: nil, error: String(localized: "WIDGET_ERROR_DISTRICT_URL_INVALID", defaultValue: "Error loading district URL.\nPlease find your district again within Pupil."))
            completion(Timeline(entries: [entry], policy: .never))
            return
        }
        
        guard let selectedCourse = configuration.courseName else {
            let entry = CourseWidgetEntry(date: Date(), configuration: configuration, course: nil, error: String(localized: "WIDGET_ERROR_NO_CLASS_CHOSEN", defaultValue: "Choose a class to display grades for.\nEdit the widget to continue.", comment: "The user has not chosen a class to view the grades of"))
            completion(Timeline(entries: [entry], policy: .never))
            return
        }
        
        let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)
        
        guard let password = keychain["password"] else {
            let entry = CourseWidgetEntry(date: Date(), configuration: configuration, course: nil, error: String(localized: "WIDGET_ERROR_UNABLE_TO_GET_PASSWORD", defaultValue: "Error retrieving user password.\nTry logging into the app."))
            completion(Timeline(entries: [entry], policy: .never))
            return
        }
        
        let credentials = Credentials(username: Defaults[.username], password: password, districtURL: district)
        let studentVue = StudentVue(credentials: credentials)
        
        Task {
            do {
                let result = try await studentVue.getGradebook()
                let course = result.courses.first(where: { course in
                    course.title == selectedCourse
                })
                let entry = CourseWidgetEntry(date: Date(), configuration: configuration, course: course, error: nil)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*60)))
                completion(timeline)
            } catch {
                let entry = CourseWidgetEntry(date: Date(), configuration: configuration, course: nil, error: error.localizedDescription)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*60)))
                completion(timeline)
            }
        }
    }
}
