//
//  LoginView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/5/22.
//

import SwiftUI
import SwiftVue
import Combine
import Defaults

enum FocusedField: Hashable {
    case username
    case password
}

struct LoginView: View {
    @EnvironmentObject private var vm: LoginViewModel
    @FocusState private var focused: FocusedField?
    @State private var isPerformingTask = false
    @Default(.useBiometrics) var useBiometric
    @Default(.accentColor) var accentColor
    
    @State private var biometricTask: AnyCancellable?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Welcome to Pupil!")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    TextField("Username", text: $vm.username)
                        .focused($focused, equals: .username)
                        .textContentType(.username)
                        .submitLabel(.next)
                        .padding()
                        .background(Color.init(.systemGray5))
                        .cornerRadius(10.0)
                        .padding(.horizontal)
                    
                    SecureField("Password", text: $vm.password)
                        .focused($focused, equals: .password)
                        .textContentType(.password)
                        .submitLabel(.go)
                        .padding()
                        .background(Color.init(.systemGray5))
                        .cornerRadius(10.0)
                        .padding(.horizontal)
                        .onSubmit {
                            button.trigger()
                        }
                    
                    Button {
                        vm.showDistrictPicker = true
                    } label: {
                        Label(vm.district?.name ?? "Select District", systemImage: "building.2.fill")
                            .font(.body.weight(.semibold))
                            .tint(accentColor)
                    }
                    .padding(.top, 5)
                    
                    if let error = vm.error {
                        Text(error)
                            .font(.body.weight(.semibold))
                            .foregroundColor(.red)
                    }
                    
                    button
                    
                    NavigationLink(isActive: $vm.loggedIn) {
                        if let district = vm.district {
                            NavigationView {
                                HomeView(credentials: Credentials(username: vm.username, password: vm.password, districtURL: district.url))
                                    .environment(\.logout, LogoutAction(action: { vm.logout() }))
                                    .navigationBarHidden(true)
                            }
                            .navigationBarHidden(true)
                            .navigationViewStyle(.stack)
                        }
                    } label: {
                        EmptyView()
                    }
                    
                }
                .frame(maxWidth: 500)
                
                if useBiometric {
                    VStack {
                        Spacer()
                        Button {
                            biometricTask = BiometricAuthUtlity.shared.authenticate()
                                .receive(on: DispatchQueue.main)
                                .sink { completion in
                                    switch completion {
                                    case .failure(let error):
                                        vm.error = error.localizedDescription
                                    case .finished:
                                        return
                                    }
                                } receiveValue: { _ in
                                    vm.loadCredentials()
                                    button.trigger()
                                }
                        } label: {
                            if let type = vm.getBiometricType() {
                                Image(systemName: type)
                                    .font(.largeTitle)
                                    .tint(accentColor)
                            }
                        }
                        .padding()
                    }
                }
            }
            .onSubmit {
                switch focused {
                case .username:
                    focused = .password
                case .password:
                    focused = nil
                    button.trigger()
                default:
                    return
                }
            }
            .sheet(isPresented: $vm.showDistrictPicker) {
                DistrictPickerView()
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        .onAppear {
            if useBiometric {
                biometricTask = BiometricAuthUtlity.shared.authenticate()
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion {
                        case .failure(let error):
                            vm.error = error.localizedDescription
                        case .finished:
                            return
                        }
                    } receiveValue: { _ in
                        vm.loadCredentials()
                        button.trigger()
                    }
            }
        }
    }
    
    var button: AsyncButton {
        AsyncButton(action: {
            if !vm.formValid {
                return
            }
            focused = nil
            await vm.login()
        }, text: "Sign In", disabled: !vm.formValid, isPerformingTask: $isPerformingTask)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
    }
}
