//
//  SettingsAliasManager.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/12/23.
//

import SwiftUI
import Defaults
import WidgetKit
import SwiftData

struct SettingsAliasManager: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Query(sort: \Alias.name, order: .forward) private var aliases: [Alias]
    @State private var showingAddAlias: Bool = false
    @State private var showingConfirmation: Bool = false
    
    var body: some View {
        ZStack {
            List {
                ForEach(aliases) { alias in
                    NavigationLink {
                        AliasEditor(alias: alias)
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
                .onDelete(perform: delete)
            }
            .listStyle(.inset)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(String(localized: "CLEAR_ALL_ALIASES_BUTTON", defaultValue: "Clear All", comment: "Clear all aliases")) {
                        showingConfirmation = true
                    }
                    .confirmationDialog(String(localized: "CLEAR_ALL_ALIASES_CONFIRM_MSG", defaultValue: "Clear all aliases?", comment: "Asking for confirmation to clear all aliases"), isPresented: $showingConfirmation) {
                        Button(String(localized: "CLEAR_ALL_ALIASES_FINAL_BUTTON", defaultValue: "Clear Aliases", comment: "Button for the user to confirm that they want to clear all aliases"), role: .destructive) {
                            withAnimation {
                                aliases.forEach(context.delete)
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                        }
                    }
                    
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(String(localized: "SHOW_ADD_ALIAS_SCREEN", defaultValue: "Add Alias"), systemImage: "plus") {
                        showingAddAlias = true
                    }
                }
            }
            
            if aliases.isEmpty {
                Text(String(localized: "ALIAS_DESCRIPTION", defaultValue: "An alias is a name and icon you can assign to classes in your gradebook and schedule, making them easier to read and recognize.\n\nGet started by adding your first alias."))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
        .navigationTitle(String(localized: "ALIASES_NAV_TITLE", defaultValue: "Aliases"))
        .sheet(isPresented: $showingAddAlias) {
            AliasEditor(alias: nil)
        }
    }
    
    func delete(at offsets: IndexSet) {
        withAnimation {
            offsets.map { aliases[$0] }.forEach(context.delete)
        }
        WidgetCenter.shared.reloadAllTimelines()
    }
}

#Preview("SettingsAliasManager") {
    NavigationStack {
        SettingsAliasManager()
    }
}
