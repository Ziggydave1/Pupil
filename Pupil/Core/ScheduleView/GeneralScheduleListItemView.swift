//
//  GeneralScheduleListItemView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/23/23.
//

import SwiftUI
import SwiftVue
import Defaults
import SwiftData

struct GeneralScheduleListItemView: View {
    @State private var showingAliasChooser: Bool = false
    @State private var showEmail: Bool = false
    @Query private var aliasLinks: [AliasLink]
    let classListing: ClassListing
    
    init(classListing: ClassListing) {
        self.classListing = classListing
        self._aliasLinks = Query(filter: #Predicate<AliasLink> { $0.key == classListing.courseTitle }, animation: .default)
    }
    
    var body: some View {
        HStack {
            Image(systemName: alias?.icon ?? "studentdesk")
                .frame(width: 28, height: 28, alignment: .center)
                .font(.title3)
            VStack(alignment: .leading, spacing: 4) {
                Text(alias?.name ?? classListing.courseTitle)
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
                .font(.largeTitle)
                .foregroundColor(.gray)
        }
        .contextMenu {
            GiveAliasButton(showingSheet: $showingAliasChooser)
            
            if let link = aliasLinks.first {
                RemoveAliasLinkButton(link: link)
            }
            
            Divider()
            
            EmailButtons(email: classListing.teacherEmail)
        }
        .sheet(isPresented: $showingAliasChooser) {
            SelectAliasSheet(key: classListing.courseTitle)
        }
    }
    
    private var alias: Alias? {
        return aliasLinks.first?.value
    }
}

#Preview("GeneralScheduleListItemView") {
    GeneralScheduleListItemView(classListing: ClassListing.preview)
}
