//
//  SettingsView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/27/23.
//

import SwiftUI
import Defaults

struct SettingsView: View {
    @EnvironmentObject private var vm: SettingsViewModel
    @Environment(\.logout) private var logout
    @Default(.useBiometrics) var useBiometrics
    @Default(.gradeColors) var gradeColors
    var body: some View {
        NavigationView {
            List {
                if let type = vm.getBiometricType() {
                    Section {
                        Defaults.Toggle("Save Login - Enable \(type)", key: .useBiometrics)
                    }
                }
                
                Section("Customization") {
                    NavigationLink {
                        ColorChooser()
                            .padding(30)
                            .navigationTitle("Grade Colors")
                    } label: {
                        Label {
                            Text("Grade Colors")
                        } icon: {
                            IconInSquare(color: .red, image: "paintpalette.fill")
                        }
                    }
                    NavigationLink {
                        SettingsAliasManager()
                    } label: {
                        Label {
                            Text("Class Names and Icons")
                        } icon: {
                            IconInSquare(color: .indigo, image: "studentdesk")
                        }
                    }
                    NavigationLink {
                        AccentColorChooser()
                            .navigationTitle("Accent Color")
                    } label: {
                        Label {
                            Text("Accent Color")
                        } icon: {
                            IconInSquare(color: .orange, image: "paintbrush.fill")
                        }
                    }

                    if UIApplication.shared.supportsAlternateIcons {
                        NavigationLink {
                            IconChooser()
                                .navigationTitle("App Icon")
                        } label: {
                            Label {
                                Text("App Icon")
                            } icon: {
                                IconInSquare(color: .green, image: "square.dashed")
                            }
                        }
                    }
                }
                
                Section("Info") {
                    if let url = URL(string: "https://pupil.framer.website/") {
                        HStack {
                            Label {
                                Text("Privacy Policy")
                            } icon: {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.primary)
                                    .frame(minWidth: 30)
                            }
                            Spacer()
                            Link(destination: url) {
                                Image(systemName: "arrow.up.right.square")
                            }
                            .tint(.secondary)
                        }
                    }
                    if let url = URL(string: "https://pupil.framer.website/") {
                        HStack {
                            Label {
                                Text("Contact Us")
                            } icon: {
                                Image(systemName: "person.2")
                                    .foregroundColor(.primary)
                                    .frame(minWidth: 30)
                            }
                            Spacer()
                            Link(destination: url) {
                                Image(systemName: "arrow.up.right.square")
                            }
                            .tint(.secondary)
                        }
                    }
                }

            }
            .navigationTitle("Settings")
            .withLogout(logout)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsViewModel(credentials: dev.credentials))
    }
}
