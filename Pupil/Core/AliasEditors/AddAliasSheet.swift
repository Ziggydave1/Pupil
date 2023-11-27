//
//  AddAliasSheet.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/8/23.
//


import SwiftUI
import Defaults

struct AddAliasSheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name: String = ""
    @State private var icon: String = "studentdesk"
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            header
            
            SymbolPicker(icon: $icon)
        }
        .alert(String(localized: "ADDING_ALIAS_ERROR", defaultValue: "Error adding alias", comment: "An error has occured adding the alias"), isPresented: $showingAlert) {
            Button(String(localized: "ADDING_ALIAS_ERROR_ACK", defaultValue: "Ok", comment: "Acknowledgement of an error that occured while adding an alias, does not do anything but dismiss"), role: .cancel) {
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
            
            TextField(String(localized: "ALIAS_ADDER_NAME_FIELD", defaultValue: "Name", comment: "Label for the name field when adding an alias"), text: $name)
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
            
            Button(String(localized: "ADD_ALIAS_BUTTON", defaultValue: "Add", comment: "Button to add an alias")) {
                guard name.count > 0 else { return }
                
                let alias = Alias(context: viewContext)
                alias.icon = icon
                alias.name = name
                
                guard viewContext.hasChanges else { return }
                
                do {
                    try viewContext.save()
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

#Preview("AddAliasSheet") {
    AddAliasSheet()
}
