//
//  EditAliasView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/13/23.
//

import SwiftUI
import Defaults
import WidgetKit

struct EditAliasView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    var alias: Alias
    @State var icon: String
    @State var name: String
    @State private var showingAlert: Bool = false
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)],
        animation: .default
    ) private var aliases: FetchedResults<Alias>
    
    var body: some View {
        VStack {
            header
            
            SymbolPicker(icon: $icon)
        }
        .alert(String(localized: "EDITING_ALIAS_ERROR", defaultValue: "Error editing alias", comment: "An error has occured editing the alias"), isPresented: $showingAlert) {
            Button(String(localized: "EDITING_ALIAS_ERROR_ACK", defaultValue: "Ok", comment: "Acknowledgement of an error that occured while editing an alias, does not do anything but dismiss"), role: .cancel) {
                dismiss()
            }
        }
    }
    
    var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(minWidth: 35)
            
            TextField(String(localized: "ALIAS_EDITOR_NAME_FIELD", defaultValue: "Name", comment: "Label for the name field when editing an alias"), text: $name)
                .padding(10)
                .background(Color(.systemGray5), in: .rect(cornerRadius: 12))
                .overlay(alignment: .trailing) {
                    if name != "" {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.medium)
                            .foregroundColor(Color(.systemGray2))
                            .padding(.trailing, 10)
                            .onTapGesture {
                                name = ""
                            }
                    }
                }
            
            Button(String(localized: "DONE_EDITING_ALIAS_BUTTON", defaultValue: "Done", comment: "Button to save an edited alias")) {
                guard name.count > 0 else { return }
                
                alias.icon = icon
                alias.name = name
                
                guard viewContext.hasChanges else { return }
                
                do {
                    try viewContext.save()
                    WidgetCenter.shared.reloadAllTimelines()
                } catch {
                    showingAlert = true
                }
                
                dismiss()
            }
        }
        .padding(.horizontal)
        .padding(.top, 5)
    }
}

#Preview("EditAliasView") {
    EditAliasView(alias: Alias(), icon: "studentdesk", name: "AP Calculus BC")
}
