//
//  IconChooser.swift
//  Pupil
//
//  Created by Evan Kaneshige on 4/10/23.
//

import SwiftUI
import Defaults

struct IconChooser: View {
    @Default(.accentColor) private var accentColor
    @State private var selectedIcon: String
    @State private var showingError: Bool = false
    let images: [String] = [
        "iconRed",
        "iconOrange",
        "iconYellow",
        "iconGreen",
        "iconLightBlue",
        "iconBlue",
        "iconPurple",
        "iconPink",
        "iconGray"
    ]
    let names: [String] = [
        String(localized: "RED", defaultValue: "Red", comment: "Name for red"),
        String(localized: "ORANGE", defaultValue: "Orange", comment: "Name for orange"),
        String(localized: "YELLOW", defaultValue: "Yellow", comment: "Name for yellow"),
        String(localized: "GREEN", defaultValue: "Green", comment: "Name for green"),
        String(localized: "LIGHT_BLUE", defaultValue: "Light Blue", comment: "Name for light blue"),
        String(localized: "BLUE", defaultValue: "Blue", comment: "Name for blue"),
        String(localized: "PURPLE", defaultValue: "Purple", comment: "Name for purple"),
        String(localized: "PINK", defaultValue: "Pink", comment: "Name for pink"),
        String(localized: "GRAY", defaultValue: "Gray", comment: "Name for gray")
    ]
    
    init() {
        if let name = UIApplication.shared.alternateIconName {
            selectedIcon = name
        } else {
            selectedIcon = "iconGreen"
        }
    }
    
    var body: some View {
        List {
            ForEach(0..<names.count, id: \.self) { index in
                HStack {
                    Button {
                        if images[index] == "iconGreen" {
                            UIApplication.shared.setAlternateIconName(nil) { error in
                                if error != nil {
                                    showingError = true
                                } else {
                                    selectedIcon = images[index]
                                }
                            }
                        } else {
                            UIApplication.shared.setAlternateIconName(images[index]) { error in
                                if error != nil {
                                    showingError = true
                                } else {
                                    selectedIcon = images[index]
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Image(uiImage: UIImage(named: images[index]) ?? UIImage())
                                .resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(.rect(cornerRadius: 10))
                            Text(names[index])
                        }
                    }
                    Spacer()
                    
                    if selectedIcon == images[index] {
                        Image(systemName: "checkmark")
                            .foregroundStyle(accentColor)
                    }
                }
            }
        }
        .listStyle(.inset)
        .alert(String(localized: "SETTING_NEW_ICON_ERROR", defaultValue: "Error setting new icon", comment: "An error occured while trying to change the icon for the app"), isPresented: $showingError) {
            Button(String(localized: "SETTING_NEW_ICON_ERROR_ACK", defaultValue: "Ok", comment: "Acknowledgement of an error that occured while setting an icon for the app, does not do anything but dismiss"), role: .cancel) {
                showingError = false
            }
        }
        .navigationTitle(String(localized: "APP_ICON_CHOOSER_NAV_TITLE", defaultValue: "App Icon", comment: "Navigation title for the app icon chooser page"))
    }
}

#Preview("IconChooser") {
    IconChooser()
}
