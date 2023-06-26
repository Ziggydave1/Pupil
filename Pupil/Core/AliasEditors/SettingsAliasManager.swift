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
                        EditAliasView(alias: alias, icon: alias.icon ?? "exclamationmark.circle.fill", name: alias.name ?? "Unknown")
                            .navigationBarHidden(true)
                    } label: {
                        HStack {
                            Image(systemName: alias.icon ?? "exclamationmark.circle.fill")
                                .frame(width: 28, height: 28, alignment: .center)
                                .font(.system(size: 25, weight: .regular))
                            Text(alias.name ?? "Unknown")
                                .font(.system(size: 18, weight: .semibold))
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
                        Text("Clear All")
                    }
                    .confirmationDialog("Clear all aliases?", isPresented: $showingConfirmation) {
                        Button("Clear Aliases", role: .destructive) {
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
                Text("An alias is a name and icon you can assign to classes in your gradebook and schedule, making them easier to read and recognize.\n\nGet started by adding your first alias.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
        .navigationTitle("Aliases")
        .sheet(isPresented: $showingAddAlias) {
            AddAliasSheet()
                .navigationBarHidden(true)
        }
        .alert("Error removing alias", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
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

struct SettingsAliasManager_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAliasManager()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
