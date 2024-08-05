//
//  SettingsView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/27/23.
//

import SwiftUI
import Defaults
import SwiftVue
import LocalAuthentication
import KeychainAccess

struct SettingsView: View {
    @Environment(\.logout) private var logout
    let credentials: Credentials
    @Default(.gradeColors) var gradeColors
    var body: some View {
        NavigationStack {
            List {
                if let type = getBiometricType() {
                    Section {
                        Defaults.Toggle(String(localized: "SETTINGS_SAVE_LOGIN_TOGGLE", defaultValue: "Save Login - Enable \(type)", comment: "Toggle label for the user to enable their login to be saved"), key: .useBiometrics)
                            .onChange {
                                let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)
                                if $0 {
                                    Defaults[.username] = credentials.username
                                    keychain["password"] = credentials.password
                                } else {
                                    Defaults[.username] = ""
                                    keychain["password"] = nil
                                }
                            }
                    }
                }
                
                Section(String(localized: "SETTINGS_SECTION_HEADER_CUSTOMIZATION", defaultValue: "Customization", comment: "List section header for the customization section in settings")) {
                    NavigationLink {
                        ColorChooser()
                            .padding(30)
                    } label: {
                        Label(String(localized: "SETTINGS_NAV_GRADE_COLORS_CHOOSER", defaultValue: "Grade Colors", comment: "Navigation link to the grade color chooser page in settings"), systemImage: "paintpalette.fill")
                            .foregroundStyle(.red)
                            .font(.headline)
                    }
                    
                    if PersistenceController.shared.enabled {
                        NavigationLink {
                            SettingsAliasManager()
                        } label: {
                            Label(String(localized: "SETTINGS_NAV_ALIASES_MANAGER", defaultValue: "Class Names and Icons", comment: "Navigation link to the alias manager page in settings"), systemImage: "studentdesk")
                                .foregroundStyle(.indigo)
                                .font(.headline)
                        }
                    } else {
                        Label("Error loading alias system", systemImage: "exclamationmark.triangle.fill")
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                    }
                    
                    NavigationLink {
                        AccentColorChooser()
                    } label: {
                        Label(String(localized: "SETTINGS_NAV_ACCENT_CHOOSER", defaultValue: "Accent Color", comment: "Navigation link to the accent color chooser page in settings"), systemImage: "paintbrush.fill")
                            .foregroundStyle(.orange)
                            .font(.headline)
                    }
                    
                    if UIApplication.shared.supportsAlternateIcons {
                        NavigationLink {
                            IconChooser()
                        } label: {
                            Label(String(localized: "SETTINGS_NAV_ICON_CHOOSER", defaultValue: "App Icon", comment: "Navigation link to the app icon chooser page in settings"), systemImage: "square.dashed")
                                .foregroundStyle(.green)
                                .font(.headline)
                        }
                    }
                }
                
                Section(String(localized: "SETTINGS_SECTION_HEADER_SCHEDULE", defaultValue: "Schedule", comment: "List section header for the schedule section in settings")) {
                    Defaults.Toggle(String(localized: "SETTINGS_OPEN_TO_TODAY_SCHEDULE_TOGGLE", defaultValue: "Open to Today Schedule", comment: "Toggle to control if the schedule opens to the today schedule or the term schedule"), key: .openToTodaySchedule)
                }
                
                Section(String(localized: "SETTINGS_SECTION_HEADER_INFO", defaultValue: "Info", comment: "List section header for the info section in settings")) {
                    if let url = URL(string: "https://pupil.framer.website/") {
                        HStack {
                            Label(String(localized: "SETTINGS_PRIVACY_POLICY_LINK", defaultValue: "Privacy Policy", comment: "Link to the website that has the privacy policy"), systemImage: "info.circle")
                                .foregroundStyle(.blue)
                                .font(.headline)
                            Spacer()
                            Link(destination: url) {
                                Image(systemName: "arrow.up.right.square")
                            }
                            .tint(.secondary)
                        }
                    }
                    if let url = URL(string: "https://pupil.framer.website/") {
                        HStack {
                            Label(String(localized: "SETTINGS_CONTACT_LINK", defaultValue: "Contact Us", comment: "Link to the website that has contact information"), systemImage: "person.2")
                                .foregroundStyle(.blue)
                                .font(.headline)
                            Spacer()
                            Link(destination: url) {
                                Image(systemName: "arrow.up.right.square")
                            }
                            .tint(.secondary)
                        }
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle(String(localized: "SETTINGS_NAV_TITLE", defaultValue: "Settings", comment: "Navigation title for the settings page"))
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(String(localized: "LOG_OUT_BUTTON_TEXT", defaultValue: "Log Out", comment: "Log out button text")) {
                        logout()
                    }
                    .tint(.red)
                    .buttonStyle(.bordered)
                }
            }
        }
    }
    
    func getBiometricType() -> String? {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            switch context.biometryType {
            case .faceID: return "Face ID"
            case .touchID: return "Touch ID"
            case .opticID: return "Optic ID"
            case .none: return nil
            @unknown default: return nil
            }
        }
        return nil
    }
}

#Preview("SettingsView") {
    SettingsView(credentials: Credentials.preview)
}
