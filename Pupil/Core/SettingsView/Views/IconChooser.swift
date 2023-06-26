//
//  IconChooser.swift
//  Pupil
//
//  Created by Evan Kaneshige on 4/10/23.
//

import SwiftUI

struct IconChooser: View {
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
        "Red",
        "Orange",
        "Yellow",
        "Green",
        "Light Blue",
        "Blue",
        "Purple",
        "Pink",
        "Gray"
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
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text(names[index])
                        }
                    }
                    Spacer()
                    
                    if selectedIcon == images[index] {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
        .listStyle(.inset)
        .alert("Error setting new icon", isPresented: $showingError) {
            Button("OK", role: .cancel) {
                showingError = false
            }
        }
    }
}

struct IconChooser_Previews: PreviewProvider {
    static var previews: some View {
        IconChooser()
    }
}
