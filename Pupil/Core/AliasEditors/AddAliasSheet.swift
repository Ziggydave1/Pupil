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
    let columns = Array<GridItem>(repeating: GridItem(), count: 6)
    let iconSet: [String: [String]] = iconList
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                    .font(.title3.weight(.semibold))
                    .frame(minWidth: 35)
                
                HStack {
                    TextField("Name", text: $name)
                    
                    if name != "" {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.medium)
                            .foregroundColor(Color(.systemGray2))
                            .padding(3)
                            .onTapGesture {
                                withAnimation {
                                    name = ""
                                }
                            }
                    }
                }
                .frame(minHeight: 35)
                .padding(.horizontal, 8)
                .background(Color(.systemGray5))
                .cornerRadius(12)
                .padding(.vertical, 10)
                
                Button("Done") {
                    if name.count > 0 {
                        withAnimation {
                            let alias = Alias(context: viewContext)
                            alias.icon = icon
                            alias.name = name
                            
                            if viewContext.hasChanges {
                                do {
                                    try viewContext.save()
                                    dismiss()
                                } catch {
                                    showingAlert = true
                                }
                            }
                        }
                    }
                    dismiss()
                }
            }
            .padding(.horizontal)
            .padding(.top, 5)
            
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 0, pinnedViews: .sectionHeaders) {
                    ForEach(iconSet.keys.sorted(), id: \.self) { category in
                        Section {
                            ForEach(iconSet[category] ?? [], id: \.self) { icon in
                                Image(systemName: icon)
                                    .font(.system(size: 18))
                                    .frame(width: 44, height: 44)
                                    .foregroundColor(.primary)
                                    .border(.green, width: icon == self.icon ? 3 : 0)
                                    .cornerRadius(6)
                                    .onTapGesture {
                                        self.icon = icon
                                    }
                            }
                        } header: {
                            HStack {
                                Text(category)
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                    .padding(.vertical, 6)
                                Spacer()
                            }
                            .background(.thinMaterial)
                        }
                    }
                }
            }
        }
        .alert("Error saving alias", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        }
    }
}

struct AddAliasSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddAliasSheet()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
