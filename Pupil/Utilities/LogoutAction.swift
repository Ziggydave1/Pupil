//
//  LogoutAction.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/15/23.
//

import Foundation
import SwiftUI

struct LogoutAction {
    typealias Action = () -> ()
    let action: Action
    func callAsFunction() {
        action()
    }
}

struct LogoutActionKey: EnvironmentKey {
    static var defaultValue: LogoutAction = LogoutAction(action: { })
}

extension EnvironmentValues {
    var logout: LogoutAction {
        get { self[LogoutActionKey.self] }
        set { self[LogoutActionKey.self] = newValue }
    }
}
