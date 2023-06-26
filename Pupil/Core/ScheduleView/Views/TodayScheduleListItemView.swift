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
    let startDate: Date?
    let endDate: Date?
    let classInfo: ClassInfo
    @Binding var currentDate: Date
    @State private var showingAliasChooser: Bool = false
    @State private var showEmail: Bool = false
    
    @FetchRequest var aliasLinks: FetchedResults<AliasLink>
    
    init(classInfo: ClassInfo, currentDate: Binding<Date>) {
        self.classInfo = classInfo
        self._currentDate = currentDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/y h:mm:ss a"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        self.startDate = dateFormatter.date(from: classInfo.startDate)
        self.endDate = dateFormatter.date(from: classInfo.endDate)
        
        self._aliasLinks = FetchRequest<AliasLink>(sortDescriptors: [], predicate: NSPredicate(format: "key = %@", classInfo.className))
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: aliasLinks.first?.value?.icon ?? "studentdesk")
                    .frame(width: 28, height: 28, alignment: .center)
                    .font(.system(size: 20, weight: .regular))
                VStack(alignment: .leading, spacing: 4) {
                    Text(aliasLinks.first?.value?.name ?? classInfo.className)
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
                if let startDate, let endDate {
                    if let period = Int(classInfo.period) {
                        Image(systemName: "\(period).circle.fill")
                            .frame(width: 42, height: 42, alignment: .center)
                            .font(.system(size: 36, weight: .regular))
                            .foregroundColor(startDate < currentDate ? endDate < currentDate ? .green : .yellow : .gray)
                    } else {
                        Text(classInfo.period)
                            .frame(width: 42, height: 42, alignment: .center)
                            .font(.system(size: 36, weight: .regular))
                            .foregroundColor(startDate < currentDate ? endDate < currentDate ? .green : .yellow : .gray)
                    }
                } else {
                    if let period = Int(classInfo.period) {
                        Image(systemName: "\(period).circle.fill")
                            .frame(width: 42, height: 42, alignment: .center)
                            .font(.system(size: 36, weight: .regular))
                            .foregroundColor(.gray)
                    } else {
                        Text(classInfo.period)
                            .frame(width: 42, height: 42, alignment: .center)
                            .font(.system(size: 36, weight: .regular))
                            .foregroundColor(.gray)
                    }
                }
            }
            if let startDate, let endDate {
                let progress = CGFloat((currentDate.timeIntervalSince1970 - startDate.timeIntervalSince1970) / (endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970))
                HStack {
                    Text(startDate, style: .time)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                    LinearProgressView(progress: progress, lineWidth: 8, color: startDate < currentDate ? endDate < currentDate ? .green : .yellow : .gray)
                    Text(endDate, style: .time)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                .foregroundColor(startDate < currentDate ? endDate < currentDate ? .green : .yellow : .gray)
            }
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
            
            if classInfo.teacherEmail.count > 0 {
                Divider()
                Button {
                    UIPasteboard.general.string = classInfo.teacherEmail.lowercased()
                } label: {
                    Text("Copy Email")
                    Image(systemName: "doc.on.doc")
                }
                
                if let emailURL = URL(string: "mailto:" + classInfo.teacherEmail.lowercased()) {
                    Link(destination: emailURL) {
                        Text("Compose Email")
                        Image(systemName: "envelope")
                    }
                    
                }
            }
        }
        .sheet(isPresented: $showingAliasChooser) {
            SelectAliasSheet(key: classInfo.className)
        }
    }
}

struct TodayScheduleListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodayScheduleListItemView(classInfo: dev.classInfo, currentDate: .constant(.now))
    }
}
