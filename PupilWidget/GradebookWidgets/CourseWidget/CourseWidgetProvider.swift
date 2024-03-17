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

struct CourseWidgetProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> CourseWidgetEntry { previewEntry() }
    
    func snapshot(for configuration: CourseConfiguration, in context: Context) async -> CourseWidgetEntry {
        if context.isPreview {
            return previewEntry(for: configuration)
        } else {
            do {
                let course = try await getCourse(withName: configuration.courseName)
                return CourseWidgetEntry(date: Date(), configuration: configuration, result: .success(course))
            } catch {
                return CourseWidgetEntry(date: Date(), configuration: configuration, result: .failure(error))
            }
        }
    }
    
    func timeline(for configuration: CourseConfiguration, in context: Context) async -> Timeline<CourseWidgetEntry> {
        do {
            let course = try await getCourse(withName: configuration.courseName)
            let entry = CourseWidgetEntry(date: Date(), configuration: configuration, result: .success(course))
            return Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*60)))
        } catch {
            let entry = CourseWidgetEntry(date: Date(), configuration: configuration, result: .failure(error))
            return Timeline(entries: [entry], policy: .never)
        }
    }
    
    func getCourse(withName name: String?) async throws -> Course {
        guard Defaults[.useBiometrics] else {
            throw PupilWidgetError.saveLoginNotEnabled
        }
        guard let district = Defaults[.district]?.url else {
            throw PupilWidgetError.invalidDistrictURL
        }
        guard let selectedCourse = name else {
            throw PupilWidgetError.noSelectedCourse
        }
        
        let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)
        
        guard let password = keychain["password"] else {
            throw PupilWidgetError.unableToGetPassword
        }
        
        let credentials = Credentials(username: Defaults[.username], password: password, districtURL: district)
        let studentVue = StudentVue(credentials: credentials)
        
        let result = try await studentVue.getGradebook()
        guard let course = result.courses.first(where: { $0.title == selectedCourse }) else {
            throw PupilWidgetError.unableToFindCourse
        }
        return course
    }
    
    func previewEntry(for configuration: CourseConfiguration = CourseConfiguration()) -> CourseWidgetEntry {
        CourseWidgetEntry(date: Date(), configuration: configuration, result: .success(Course.preview))
    }
}
