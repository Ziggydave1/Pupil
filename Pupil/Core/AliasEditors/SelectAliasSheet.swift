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
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Alias.name, order: .forward) private var aliases: [Alias]
    
    let key: String
    @State private var showingAddAlias: Bool = false
    @State private var showingAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(aliases) { alias in
                        Button {
                            let newLink = AliasLink(key: key)
                            newLink.value = alias
                            
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
                        Button {
                            showingAddAlias = true
                        } label: {
                            Image(systemName: "plus")
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
            .alert(String(localized: "SETTING_ALIAS_ERROR", defaultValue: "Error setting alias", comment: "An error has occured setting the alias"), isPresented: $showingAlert) {
                Button(String(localized: "SETTING_ALIAS_ERROR_ACK", defaultValue: "Ok", comment: "Acknowledgement of an error that occured while setting an alias, does not do anything but dismiss"), role: .cancel) {
                    dismiss()
                }
            }
        }
    }
}

#Preview("SelectAliasSheet") {
    SelectAliasSheet(key: "AP CALC BC (350151)")
}
