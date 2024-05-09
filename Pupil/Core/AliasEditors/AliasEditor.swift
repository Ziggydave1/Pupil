//
//  AliasEditor.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/17/24.
//

import SwiftUI
import WidgetKit

struct AliasEditor: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var name: String = ""
    @State private var icon: String = "studentdesk"
    let alias: Alias?
    
    private var editorDoneButtonText: String {
        if alias == nil {
            return String(localized: "ADD_ALIAS_BUTTON", defaultValue: "Add", comment: "Button to add an alias")
        } else {
            return String(localized: "DONE_EDITING_ALIAS_BUTTON", defaultValue: "Done", comment: "Button to save an edited alias")
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(minWidth: 35)
                
                TextField(String(localized: "ALIAS_EDITOR_NAME", defaultValue: "Name", comment: "Label for the name field in the alias editor"), text: $name)
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
                
                Button(editorDoneButtonText) {
                    save()
                    dismiss()
                }
            }
            .padding(.horizontal)
            .padding(.top, 5)
            
            SymbolPicker(icon: $icon)
        }
        .toolbar(.hidden)
        .onAppear {
            if let alias {
                name = alias.name
                icon = alias.icon
            }
        }
    }
    
    func save() {
        if let alias {
            alias.name = name
            alias.icon = icon
        } else {
            let newAlias = Alias(name: name, icon: icon)
            context.insert(newAlias)
        }
        
        WidgetCenter.shared.reloadAllTimelines()
    }
}

#Preview("AliasEditor") {
    AliasEditor(alias: nil)
}
