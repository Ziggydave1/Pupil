//
//  PupilWidgetError.swift
//  PupilWidgetExtension
//
//  Created by Evan Kaneshige on 3/16/24.
//

import Foundation

enum PupilWidgetError: LocalizedError {
    case saveLoginNotEnabled
    case invalidDistrictURL
    case noSelectedCourse
    case unableToGetPassword
    case unableToFindCourse
    
    var errorDescription: String {
        switch self {
        case .saveLoginNotEnabled:
            return String(localized: "WIDGET_ERROR_LOGIN_NOT_SAVED", defaultValue: "Enable save login within Pupil to use this widget.", comment: "The user credentials are not saved, which the widget requires to work")
        case .invalidDistrictURL:
            return String(localized: "WIDGET_ERROR_DISTRICT_URL_INVALID", defaultValue: "Error loading district URL.\nPlease find your district again within Pupil.", comment: "The users district url is invalid")
        case .noSelectedCourse:
            return String(localized: "WIDGET_ERROR_NO_CLASS_CHOSEN", defaultValue: "Choose a class to display grades for.\nEdit the widget to continue.", comment: "The user has not chosen a class to view the grades of")
        case .unableToGetPassword:
            return String(localized: "WIDGET_ERROR_UNABLE_TO_GET_PASSWORD", defaultValue: "Error retrieving user password.\nTry logging into the app.", comment: "The user password was unable to be retrieved")
        case.unableToFindCourse:
            return String(localized: "WIDGET_ERROR_COURSE_NOT_FOUND", defaultValue: "Selected course not found in gradebook", comment: "The course picked for the widget was not present in the gradebook")
        }
    }
}
