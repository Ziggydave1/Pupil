//
//  DistrictPickerView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/2/22.
//

import SwiftUI

struct DistrictPickerView: View {
    @EnvironmentObject private var vm: LoginViewModel
    var body: some View {
        NavigationView {
            VStack {
                TextField("Zip Code", text: $vm.zipCode)
                    .textContentType(.username)
                    .keyboardType(.numberPad)
                    .submitLabel(.search)
                    .padding(10)
                    .background(Color.init(.systemGray5))
                    .cornerRadius(10.0)
                    .padding(.horizontal)
                if vm.loading {
                    Spacer()
                    ProgressView()
                        .tint(.gray)
                    Spacer()
                } else  {
                    List {
                        ForEach(vm.districts) { district in
                            Button {
                                vm.district = district
                                vm.showDistrictPicker = false
                            } label: {
                                DistrictRowView(district: district)
                            }
                        }
                    }
                    .listStyle(.inset)
                }
            }
            .navigationTitle("Find Your District")
        }
        .navigationViewStyle(.stack)
    }
}

struct DistrictPickerView_Previews: PreviewProvider {
    static var previews: some View {
        DistrictPickerView()
            .environmentObject(LoginViewModel())
    }
}
