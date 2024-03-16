//
//  AccentColorChooser.swift
//  Pupil
//
//  Created by Evan Kaneshige on 4/10/23.
//

import SwiftUI
import Defaults

struct AccentColorChooser: View {
    @Default(.accentColor) var accentColor
    @Default(.accentColorName) var accentColorName
    let colors = [Color.red, Color.orange, Color.yellow, Color.green, Color.mint, Color.teal, Color.cyan, Color.blue, Color.indigo, Color.purple, Color.pink, Color.brown]
    let colorNames = [
        String(localized: "RED", defaultValue: "Red"),
        String(localized: "ORANGE", defaultValue: "Orange"),
        String(localized: "YELLOW", defaultValue: "Yellow"),
        String(localized: "GREEN", defaultValue: "Green"),
        String(localized: "MINT", defaultValue: "Mint", comment: "Name for mint color"),
        String(localized: "TEAL", defaultValue: "Teal", comment: "Name for teal"),
        String(localized: "CYAN", defaultValue: "Cyan", comment: "Name for cyan"),
        String(localized: "BLUE", defaultValue: "Blue"),
        String(localized: "INDIGO", defaultValue: "Indigo", comment: "Name for indigo"),
        String(localized: "PURPLE", defaultValue: "Purple"),
        String(localized: "PINK", defaultValue: "Pink", comment: "Name for pink"),
        String(localized: "BROWN", defaultValue: "Brown", comment: "Name for brown")
    ]
    var body: some View {
        List {
            ForEach(0..<colors.count, id: \.self) { index in
                HStack {
                    Button {
                        accentColor = colors[index]
                        accentColorName = colorNames[index]
                    } label: {
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colors[index])
                                .frame(width: 50, height: 50)
                                .padding(5)
                            
                            Text(colorNames[index])
                        }
                    }
                    
                    Spacer()
                    
                    if colorNames[index] == accentColorName {
                        Image(systemName: "checkmark")
                            .foregroundStyle(accentColor)
                    }
                }
            }
        }
        .listStyle(.inset)
        .navigationTitle(String(localized: "ACCENT_COLOR_CHOOSER_NAV_TITLE", defaultValue: "Accent Color", comment: "Navigation title for the accent color chooser page"))
    }
}

#Preview("AccentColorChooser") {
    AccentColorChooser()
}
