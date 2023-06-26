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
        CourseWidgetEntry(date: Date(), configuration: CourseConfigurationIntent(), course: PreviewData.instance.multiMarkCourse, error: nil)
    }
    
    func getSnapshot(for configuration: CourseConfigurationIntent, in context: Context, completion: @escaping (CourseWidgetEntry) -> ()) {
        completion(CourseWidgetEntry(date: Date(), configuration: configuration, course: PreviewData.instance.multiMarkCourse, error: nil))
    }
    
    func getTimeline(for configuration: CourseConfigurationIntent, in context: Context, completion: @escaping (Timeline<CourseWidgetEntry>) -> ()) {
        guard Defaults[.useBiometrics] else {
            let entry = CourseWidgetEntry(date: Date(), configuration: configuration, course: nil, error: "Enable save login in Pupil to use this widget.")
            completion(Timeline(entries: [entry], policy: .never))
            return
        }
        
        guard let district = Defaults[.district]?.url else {
            let entry = CourseWidgetEntry(date: Date(), configuration: configuration, course: nil, error: "Error loading district URL.")
            completion(Timeline(entries: [entry], policy: .never))
            return
        }
        
        guard let selectedCourse = configuration.courseName else {
            let entry = CourseWidgetEntry(date: Date(), configuration: configuration, course: nil, error: "Choose a class to display grades for.")
            completion(Timeline(entries: [entry], policy: .never))
            return
        }
        
        let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)
        
        guard let password = keychain["password"] else {
            let entry = CourseWidgetEntry(date: Date(), configuration: configuration, course: nil, error: "Error retrieving user password.")
            completion(Timeline(entries: [entry], policy: .never))
            return
        }
        
        let studentVue = StudentVue(username: Defaults[.username], password: password, districtURL: district)
        
        Task {
            let result = await studentVue.getGradebook()
            switch result {
            case .success(let success):
                let course = success.courses.first(where: { course in
                    course.title == selectedCourse
                })
                let entry = CourseWidgetEntry(date: Date(), configuration: configuration, course: course, error: nil)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*60)))
                completion(timeline)
            case .failure(let failure):
                let entry = CourseWidgetEntry(date: Date(), configuration: configuration, course: nil, error: failure.localizedDescription)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*60)))
                completion(timeline)
            }
        }
    }
}
