//
//  GeneralScheduleListItemView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/23/23.
//

import SwiftUI
import SwiftVue
import Defaults

struct GeneralScheduleListItemView: View {
    let classListing: ClassListing
    @State private var showingAliasChooser: Bool = false
    @State private var showEmail: Bool = false
    
    @FetchRequest var aliasLinks: FetchedResults<AliasLink>
    
    init(classListing: ClassListing) {
        self.classListing = classListing
        self._aliasLinks = FetchRequest<AliasLink>(sortDescriptors: [], predicate: NSPredicate(format: "key = %@", classListing.courseTitle))
    }
    
    var body: some View {
        HStack {
            Image(systemName: aliasLinks.first?.value?.icon ?? "studentdesk")
                .frame(width: 28, height: 28, alignment: .center)
                .font(.system(size: 20, weight: .regular))
            VStack(alignment: .leading, spacing: 4) {
                Text(aliasLinks.first?.value?.name ?? classListing.courseTitle)
                    .font(.headline)
                Group {
                    if showEmail {
                        Text(classListing.teacherEmail.lowercased() + " | " + classListing.roomName)
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .top)), removal: .opacity))
                    } else {
                        HStack(spacing: 3) {
                            Text(classListing.teacher + " | " + classListing.roomName)
                            if classListing.teacherEmail.count > 0 {
                                Image(systemName: "info.circle")
                            }
                        }
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .top)), removal: .opacity))
                    }
                }
                .onTapGesture {
                    if classListing.teacherEmail.count > 0 {
                        withAnimation {
                            showEmail.toggle()
                        }
                    }
                }
            }
            .padding(4)
            Spacer()
            Image(systemName: "\(classListing.period).circle.fill")
                .frame(width: 42, height: 42, alignment: .center)
                .font(.system(size: 36, weight: .regular))
                .foregroundColor(.gray)
        }
        .contextMenu {
            Button {
                showingAliasChooser.toggle()
            } label: {
                Label("Give Alias", systemImage: "plus")
            }
            
            if let link = aliasLinks.first {
                Button(role: .destructive) {
                    PersistenceController.shared.delete(link)
                } label: {
                    Text("Remove Alias")
                    Image(systemName: "trash")
                }
                
            }
            
            if classListing.teacherEmail.count > 0 {
                Divider()
                Button {
                    UIPasteboard.general.string = classListing.teacherEmail.lowercased()
                } label: {
                    Text("Copy Email")
                    Image(systemName: "doc.on.doc")
                }
                
                if let emailURL = URL(string: "mailto:" + classListing.teacherEmail.lowercased()) {
                    Link(destination: emailURL) {
                        Text("Compose Email")
                        Image(systemName: "envelope")
                    }
                    
                }
            }
        }
        .sheet(isPresented: $showingAliasChooser) {
            SelectAliasSheet(key: classListing.courseTitle)
        }
    }
}

struct GeneralScheduleListItemView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralScheduleListItemView(classListing: dev.classListing)
    }
}
