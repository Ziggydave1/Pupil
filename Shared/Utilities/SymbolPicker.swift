//
//  SymbolPicker.swift
//  Pupil
//
//  Created by Evan Kaneshige on 10/4/23.
//

import SwiftUI
import Symbols

struct SymbolPicker: View {
    @Binding var icon: String
    let columns = [GridItem(.adaptive(minimum: 50))]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, pinnedViews: .sectionHeaders) {
                ForEach(icons) { category in
                    Section {
                        ForEach(category.icons, id: \.self) { item in
                            Button {
                                self.icon = item
                            } label: {
                                Image(systemName: item)
                            }
                            .font(.title2)
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fill)
                            .background(item == self.icon ? Color(.systemGray3) : Color(.systemGray6), in: .rect(cornerRadius: 6))
                        }
                    } header: {
                        HStack {
                            Text(category.name)
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                                .padding(.vertical, 6)
                            Spacer()
                        }
                        .background(.thinMaterial)
                    }
                }
            }
        }
    }
    
    struct IconList: Identifiable {
        var name: String
        var icons: [String]
        
        var id: UUID = UUID()
    }
    
    let icons: [IconList] = [
        IconList(name: "General", icons: ["building.2", "scribble", "doc", "doc.text", "doc.richtext", "doc.plaintext", "doc.append", "calendar", "book", "books.vertical", "book.closed", "character.book.closed", "text.book.closed", "magazine", "newspaper", "graduationcap", "ruler", "studentdesk", "paperclip", "bubble.left", "quote.bubble"]),
        IconList(name: "Science", icons: ["atom", "scalemass", "bandage", "pills", "testtube.2", "pawprint", "leaf", "gearshape.2", "lungs", "allergens", "brain.head.profile", "brain", "bolt", "stethoscope", "burst", "waveform.path"]),
        IconList(name: "Math", icons: ["function", "chart.pie", "chart.line.uptrend.xyaxis", "cube.transparent", "infinity", "square.on.circle", "x.squareroot", "torus", "sum", "plus.forwardslash.minus"]),
        IconList(name: "Arts", icons: ["paintpalette", "guitars", "film", "ticket", "music.note", "music.note.list", "music.quarternote.3", "music.mic", "photo.artframe", "camera", "pianokeys", "paintbrush.pointed", "paintbrush", "photo", "theatermasks"]),
        IconList(name: "Social Studies", icons: ["globe", "globe.americas", "globe.europe.africa", "globe.asia.australia", "building.columns", "scroll", "dollarsign.circle", "person.2"]),
        IconList(name: "Technology", icons: ["keyboard", "cpu", "display", "desktopcomputer", "pc", "laptopcomputer", "tv", "gamecontroller", "chevron.left.forwardslash.chevron.right", "computermouse", "headphones"]),
        IconList(name: "Other", icons: ["hammer", "house", "car", "fork.knife", "sportscourt"])
    ]
}

#Preview {
    SymbolPickerPreview()
}

struct SymbolPickerPreview: View {
    @State private var icon: String = "studentdesk"
    var body: some View {
        SymbolPicker(icon: $icon)
    }
}
