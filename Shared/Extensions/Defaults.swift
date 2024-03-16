//
//  Defaults.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/2/23.
//

import SwiftUI
import Defaults
import SwiftVue

let pupilGroupDefaults = UserDefaults(suiteName: App_Group)!

extension Defaults.Keys {
    static let gradeColors = Key<GradeColors>(UD_Grade_Colors, default: GradeColors.defaultTheme, suite: pupilGroupDefaults)
    static let district = Key<DistrictInfo?>(UD_District, suite: pupilGroupDefaults)
    static let username = Key<String>(UD_Username, default: "", suite: pupilGroupDefaults)
    static let useBiometrics = Key<Bool>(UD_Use_Biometric, default: false, suite: pupilGroupDefaults)
    static let courseList = Key<[String]>(UD_Course_List, default: [], suite: pupilGroupDefaults)
    static let accentColor = Key<Color>(UD_Accent_Color, default: .green, suite: pupilGroupDefaults)
    static let accentColorName = Key<String>(UD_Accent_Color_Name, default: "Green", suite: pupilGroupDefaults)
    static let customIDPhoto = Key<Data?>(UD_Custom_ID_Photo, suite: pupilGroupDefaults)
    static let recentDistricts = Key<[DistrictInfo]>(UD_Recent_Districts, default: [], suite: pupilGroupDefaults)
    static let firstLogin = Key<Bool>(UD_First_Login, default: true, suite: pupilGroupDefaults)
    static let openToTodaySchedule = Key<Bool>(UD_Open_To_Today_Schedule, default: true, suite: pupilGroupDefaults)
}

extension DistrictInfo: Defaults.Serializable {
    
}
