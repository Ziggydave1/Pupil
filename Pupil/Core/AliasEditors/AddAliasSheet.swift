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
        .alert("Error saving alias", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        }
    }
    
    var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3.weight(.semibold))
                .frame(minWidth: 35)
            
            TextField("Name", text: $name)
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
            
            Button("Done") {
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

struct AddAliasSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddAliasSheet()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
