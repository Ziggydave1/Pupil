//
//  PupilView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/10/23.
//

import SwiftUI
import SwiftVue
import Defaults
import KeychainAccess

struct PupilView: View {
    @State private var credentials: Credentials?
    @State private var showingLoginView: Bool = true
    var body: some View {
        Group {
            if let credentials {
                HomeView(credentials: credentials)
                    .environment(\.logout) {
                        logout()
                    }
            } else {
                Button(String(localized: "PLEASE_AUTHENTICATE_BUTTON", defaultValue: "Please authenticate", comment: "Button to show the login screen because the user is not authenticated")) {
                    showingLoginView = true
                }
                .font(.headline)
            }
        }
        .fullScreenCover(isPresented: $showingLoginView) {
            DistrictPickerView(credentials: $credentials)
        }
        .onChange(of: credentials) { _, newValue in
            showingLoginView = newValue == nil
        }
    }
    
    private func logout() {
        Defaults[.username] = ""
        Defaults[.useBiometrics] = false
        Defaults[.firstLogin] = true
        Defaults[.courseList] = []
        
        let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)
        keychain["password"] = nil
        
        self.credentials = nil
    }
}

#Preview("PupilView") {
    PupilView()
}
