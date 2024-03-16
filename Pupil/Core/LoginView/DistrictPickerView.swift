//
//  DistrictPickerView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/2/22.
//

import SwiftUI
import SwiftVue
import Defaults

struct DistrictPickerView: View {
    @Default(.recentDistricts) private var recentDistricts: [DistrictInfo]
    @State private var zipCode: String = ""
    @State private var loading: Bool = false
    @State private var districts: [DistrictInfo] = []
    @State private var error: Error?
    
    @State private var searchTask: Task<Void, Never>?
    
    @State private var path: [DistrictInfo]
    
    @Binding var credentials: Credentials?
    
    init(credentials: Binding<Credentials?>) {
        self._credentials = credentials
        if let district = Defaults[.district] {
            self.path = [district]
        } else {
            self.path = []
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TextField(String(localized: "DISTRICT_FINDER_ZIP", defaultValue: "Zip Code", comment: "The zip code field"), text: $zipCode)
                    .textContentType(.username)
                    .keyboardType(.numberPad)
                    .submitLabel(.search)
                    .padding(10)
                    .background(Color.init(.systemGray5))
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(.horizontal)
                
                List {
                    if !loading && districts.isEmpty && !recentDistricts.isEmpty {
                        Section(String(localized: "RECENTLY_SEARCHED_DISTRICTS", defaultValue: "Recently Searched", comment: "The recently searched section in the district list")) {
                            ForEach(recentDistricts) { district in
                                NavigationLink(value: district) {
                                    DistrictRowView(district: district)
                                }
                            }
                        }
                    }
                    ForEach(districts) { district in
                        NavigationLink(value: district) {
                            DistrictRowView(district: district)
                        }
                    }
                }
                .listStyle(.inset)
            }
            .overlay {
                if loading {
                    ProgressView()
                }
            }
            .navigationTitle(String(localized: "FIND_YOUR_DISTRICT_NAV_TITLE", defaultValue: "Find Your District", comment: "Navigation title for the district picker to instruct the user on what to do"))
            .navigationDestination(for: DistrictInfo.self) { district in
                LoginView(district: district, credentials: $credentials, path: $path)
            }
        }
        .onChange(of: zipCode) { _ in
            getDistricts()
        }
        .onAppear {
            if let district =  Defaults[.district] {
                path.append(district)
            }
        }
    }
    
    private func getDistricts() {
        searchTask?.cancel()
        districts = []
        
        let searchTerm = zipCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard searchTerm.count > 2 else {
            loading = false
            return
        }
        
        searchTask = Task {
            loading = true
            do {
                districts = try await StudentVue.getDistrictList(zip: searchTerm)
            } catch {
                districts = []
                self.error = error
            }
            if !Task.isCancelled {
                loading = false
            }
        }
    }
}

#Preview("DistrictPickerView") {
    DistrictPickerView(credentials: .constant(nil))
}
