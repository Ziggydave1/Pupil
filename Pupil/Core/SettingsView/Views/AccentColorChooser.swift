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
    let colorNames = ["Red", "Orange", "Yellow", "Green", "Mint", "Teal", "Cyan", "Blue", "Indigo", "Purple", "Pink", "Brown"]
    var body: some View {
        List {
            LazyVGrid(columns: Array<GridItem>(repeating: GridItem(), count: 3), spacing: 10) {
                ForEach(0..<colors.count, id: \.self) { index in
                    Button {
                        accentColor = colors[index]
                        accentColorName = colorNames[index]
                    } label: {
                        VStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(colors[index])
                                .frame(width: 55, height: 55)
                                .cornerRadius(14)
                                .padding(5)
                                .overlay {
                                    if colorNames[index] == accentColorName {
                                        RoundedRectangle(cornerRadius: 19)
                                            .stroke(.gray, lineWidth: 5)
                                    }
                                }
                            
                            Text(colorNames[index])
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .listStyle(.inset)
    }
}

struct AccentColorChooser_Previews: PreviewProvider {
    static var previews: some View {
        AccentColorChooser()
    }
}
