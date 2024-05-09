//
//  SelectAliasSheet.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/6/23.
//

import SwiftUI
import Defaults
import WidgetKit
import SwiftData

struct SelectAliasSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Query(sort: \Alias.name, order: .forward) private var aliases: [Alias]
    @State private var showingAddAlias: Bool = false
    let key: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(aliases) { alias in
                        Button {
                            let newLink = AliasLink(key: key, value: alias)
                            context.insert(newLink)
                            WidgetCenter.shared.reloadAllTimelines()
                            dismiss()
                        } label: {
                            HStack {
                                Image(systemName: alias.icon)
                                    .frame(width: 28, height: 28, alignment: .center)
                                    .font(.title2)
                                Text(alias.name)
                                    .font(.headline)
                                    .padding(4)
                                Spacer()
                            }
                        }
                    }
                }
                .listStyle(.inset)
                .navigationTitle(String(localized: "ALIASES_NAV_TITLE", defaultValue: "Aliases", comment: "Navigation title for the page where someone can select an alias to use"))
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(String(localized: "SHOW_ADD_ALIAS_SCREEN", defaultValue: "Add Alias", comment: "Shows the add alias screen"), systemImage: "plus") {
                            showingAddAlias = true
                        }
                    }
                }
                .sheet(isPresented: $showingAddAlias) {
                    AliasEditor(alias: nil)
                }
                if aliases.isEmpty {
                    Text(String(localized: "ALIAS_DESCRIPTION", defaultValue: "An alias is a name and icon you can assign to classes in your gradebook and schedule, making them easier to read and recognize.\n\nGet started by adding your first alias.", comment: "Description of what an alias is for new users"))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
        }
    }
}

#Preview("SelectAliasSheet") {
    SelectAliasSheet(key: "AP CALC BC (350151)")
}
