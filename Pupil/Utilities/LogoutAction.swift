//
//  LogoutAction.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/29/24.
//

import Foundation
import SwiftUI

typealias LogoutAction = () -> ()

struct LogoutKey: EnvironmentKey {
    static var defaultValue: LogoutAction = { }
}

extension EnvironmentValues {
    var logout: LogoutAction {
        get { self[LogoutKey.self] }
        set { self[LogoutKey.self] = newValue }
    }
}
