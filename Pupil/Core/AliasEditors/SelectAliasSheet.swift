//
//  SelectAliasSheet.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/6/23.
//

import SwiftUI
import Defaults
import WidgetKit

struct SelectAliasSheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)],
        animation: .default
    ) private var aliases: FetchedResults<Alias>
    
    let key: String
    @State private var showingAddAlias: Bool = false
    @State private var showingAlert: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(aliases) { alias in
                        Button {
                            if let link = PersistenceController.shared.aliasLink(for: key) {
                                link.value = alias
                            } else {
                                let newLink = AliasLink(context: viewContext)
                                newLink.key = key
                                newLink.value = alias
                            }
                            if viewContext.hasChanges {
                                do {
                                    try viewContext.save()
                                    WidgetCenter.shared.reloadAllTimelines()
                                    dismiss()
                                } catch {
                                    showingAlert = true
                                }
                            }
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
                }
                .listStyle(.inset)
                .navigationTitle("Aliases")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        if let link = PersistenceController.shared.aliasLink(for: key) {
                            Button(role: .destructive) {
                                PersistenceController.shared.delete(link)
                                dismiss()
                            } label: {
                                Text("Remove Alias")
                            }
                            .tint(.red)
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
                .sheet(isPresented: $showingAddAlias) {
                    AddAliasSheet()
                        .navigationBarHidden(true)
                }
                if aliases.isEmpty {
                    Text("An alias is a name and icon you can assign to classes in your gradebook and schedule, making them easier to read and recognize.\n\nGet started by adding your first alias.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            .alert("Error setting alias", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {
                    dismiss()
                }
            }
        }
    }
}

struct SelectAliasSheet_Previews: PreviewProvider {
    static var previews: some View {
        SelectAliasSheet(key: "AP CALC BC (350151)")
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
