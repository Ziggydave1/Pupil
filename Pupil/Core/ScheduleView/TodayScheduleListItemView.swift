//
//  TodayScheduleListItemView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/23/23.
//

import SwiftUI
import SwiftVue
import Defaults

struct TodayScheduleListItemView: View {
    let classInfo: ClassInfo
    let currentDate: Date
    @State private var showingAliasChooser: Bool = false
    @State private var showEmail: Bool = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.key)]) var aliasLinks: FetchedResults<AliasLink>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var aliases: FetchedResults<Alias>
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: alias?.icon ?? "studentdesk")
                    .frame(width: 28, height: 28, alignment: .center)
                    .font(.title3)
                VStack(alignment: .leading, spacing: 4) {
                    Text(alias?.name ?? classInfo.className)
                        .font(.headline)
                    Group {
                        if showEmail {
                            Text(classInfo.teacherEmail.lowercased() + " | " + classInfo.roomName)
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .top)), removal: .opacity))
                        } else {
                            HStack(spacing: 3) {
                                Text(classInfo.teacher + " | " + classInfo.roomName)
                                if classInfo.teacherEmail.count > 0 {
                                    Image(systemName: "info.circle")
                                }
                            }
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .top)), removal: .opacity))
                        }
                    }
                    .onTapGesture {
                        if classInfo.teacherEmail.count > 0 {
                            withAnimation {
                                showEmail.toggle()
                            }
                        }
                    }
                }
                .padding(4)
                Spacer()
                if classInfo.period <= 50 {
                    Image(systemName: "\(classInfo.period).circle.fill")
                        .frame(width: 42, height: 42, alignment: .center)
                        .font(.largeTitle)
                        .foregroundColor(classInfo.startDate < currentDate ? classInfo.endDate < currentDate ? .green : .yellow : .gray)
                } else {
                    Text("\(classInfo.period)")
                        .frame(width: 42, height: 42, alignment: .center)
                        .font(.largeTitle)
                        .foregroundColor(classInfo.startDate < currentDate ? classInfo.endDate < currentDate ? .green : .yellow : .gray)
                }
            }
            let progress = CGFloat((currentDate.timeIntervalSince1970 - classInfo.startDate.timeIntervalSince1970) / (classInfo.endDate.timeIntervalSince1970 - classInfo.startDate.timeIntervalSince1970))
            HStack {
                Text(classInfo.startDate, style: .time)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                LinearProgressView(progress: progress, lineWidth: 8, color: classInfo.startDate < currentDate ? classInfo.endDate < currentDate ? .green : .yellow : .gray)
                Text(classInfo.endDate, style: .time)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
            }
            .foregroundColor(classInfo.startDate < currentDate ? classInfo.endDate < currentDate ? .green : .yellow : .gray)
        }
        .contextMenu {
            GiveAliasButton(showingSheet: $showingAliasChooser)
            
            if let aliasLink {
                RemoveAliasLinkButton(link: aliasLink)
            }
            
            Divider()
            
            EmailButtons(email: classInfo.teacherEmail)
        }
        .sheet(isPresented: $showingAliasChooser) {
            SelectAliasSheet(key: classInfo.className)
        }
    }
    
    var aliasLink: AliasLink? {
        return aliasLinks.first { $0.key == classInfo.className }
    }
    
    var alias: Alias? {
        return aliases.first(where: { $0.objectID == aliasLink?.value?.objectID })
    }
}

#Preview("TodayScheduleListItemView") {
    TodayScheduleListItemView(classInfo: ClassInfo.preview, currentDate: .now)
}
