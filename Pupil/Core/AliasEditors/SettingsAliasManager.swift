//
//  SettingsAliasManager.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/12/23.
//

import SwiftUI
import Defaults
import WidgetKit

struct SettingsAliasManager: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddAlias: Bool = false
    @State private var showingConfirmation: Bool = false
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)],
        animation: .default
    ) private var aliases: FetchedResults<Alias>
    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        ZStack {
            List {
                ForEach(aliases) { alias in
                    NavigationLink {
                        EditAliasView(alias: alias, icon: alias.icon ?? "exclamationmark.circle.fill", name: alias.name ?? String(localized: "UNKNOWN_ALIAS", defaultValue: "Unknown"))
                            .navigationBarHidden(true)
                    } label: {
                        HStack {
                            Image(systemName: alias.icon ?? "exclamationmark.circle.fill")
                                .frame(width: 28, height: 28, alignment: .center)
                                .font(.title2)
                            Text(alias.name ?? String(localized: "UNKNOWN_ALIAS", defaultValue: "Unknown"))
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
                    Button {
                        showingConfirmation = true
                    } label: {
                        Text(String(localized: "CLEAR_ALL_ALIASES_BUTTON", defaultValue: "Clear All", comment: "Clear all aliases"))
                    }
                    .confirmationDialog(String(localized: "CLEAR_ALL_ALIASES_CONFIRM_MSG", defaultValue: "Clear all aliases?", comment: "Asking for confirmation to clear all aliases"), isPresented: $showingConfirmation) {
                        Button(String(localized: "CLEAR_ALL_ALIASES_FINAL_BUTTON", defaultValue: "Clear Aliases", comment: "Button for the user to confirm that they want to clear all aliases"), role: .destructive) {
                            withAnimation {
                                aliases.forEach(viewContext.delete)
                                
                                if viewContext.hasChanges {
                                    do {
                                        try viewContext.save()
                                        WidgetCenter.shared.reloadAllTimelines()
                                    } catch {
                                        showingAlert = true
                                    }
                                }
                            }
                        }
                    }
                    
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddAlias = true
                    } label: {
                        Image(systemName: "plus")
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
            AddAliasSheet()
                .navigationBarHidden(true)
        }
        .alert(String(localized: "REMOVING_ALIAS_ERROR", defaultValue: "Error removing alias", comment: "An error has occured removing the alias"), isPresented: $showingAlert) {
            Button(String(localized: "REMOVING_ALIAS_ERROR_ACK", defaultValue: "Ok", comment: "Acknowledgement of an error that occured while removing an alias, does not do anything but dismiss"), role: .cancel) {
                dismiss()
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        withAnimation {
            offsets.map { aliases[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                showingAlert = true
            }
        }
    }
}

#Preview("SettingsAliasManager") {
    SettingsAliasManager()
}
