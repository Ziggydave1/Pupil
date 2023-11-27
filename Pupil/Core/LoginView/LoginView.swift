//
//  LoginView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/5/22.
//

import SwiftUI
import SwiftVue
import Defaults
import KeychainAccess
import Combine
import LocalAuthentication

struct LoginView: View {
    private enum FocusedField { case username, password }
    @Default(.accentColor) private var accentColor
    @FocusState private var focused: FocusedField?
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loading: Bool = false
    @State private var error: String?
    let district: DistrictInfo
    @Binding var credentials: Credentials?
    @Binding var path: [DistrictInfo]
    
    @State private var biometricTask: AnyCancellable?
    @State private var showingUseBiometricsAlert: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                if let error = error {
                    Text(error)
                        .font(.headline)
                        .foregroundColor(.red)
                }
                TextField(String(localized: "LOGIN_USERNAME", defaultValue: "Username", comment: "The username field"), text: $username)
                    .focused($focused, equals: .username)
                    .textContentType(.username)
                    .submitLabel(.next)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(.rect(cornerRadius: 15))
                
                SecureField(String(localized: "LOGIN_PASSWORD", defaultValue: "Password", comment: "The password field"), text: $password)
                    .focused($focused, equals: .password)
                    .textContentType(.password)
                    .submitLabel(.go)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(.rect(cornerRadius: 15))
                
                Button {
                    focused = nil
                    Task {
                        await login()
                    }
                } label: {
                    if loading {
                        DotProgressView()
                    } else {
                        Text(String(localized: "LOGIN_SIGN_IN_BUTTON", defaultValue: "Sign In", comment: "The sign in button"))
                    }
                }
                .font(.headline)
                .foregroundStyle(.white)
                .opacity(loading ? 0.5 : 1)
                .padding()
                .frame(maxWidth: .infinity)
                .background(formValid ? (loading ? accentColor.opacity(0.8) : accentColor) : Color.init(.systemGray5))
                .disabled(loading || !formValid)
                .clipShape(.rect(cornerRadius: 15))
            }
            .padding()
            .onSubmit(of: .text) {
                switch focused {
                case .username:
                    focused = username.isEmpty ? nil : .password
                case .password, nil:
                    focused = nil
                    if !password.isEmpty {
                        Task {
                            await login()
                        }
                    }
                }
            }
        }
        .background {
            Circle()
                .stroke(lineWidth: focused == nil ? 148 : 178)
                .foregroundStyle(accentColor.gradient.shadow(.inner(radius: 10)))
                .scaleEffect(focused == nil ? 1 : 1.8)
                .frame(width: 790, height: 790)
                .position(.zero)
                .offset(x: 90, y: -125)
                
        }
        .animation(.easeInOut, value: focused)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button {
                    path.removeAll()
                } label: {
                    Text(district.name)
                }
                .font(.headline)
                .tint(accentColor)
            }
        }
        .navigationTitle(String(localized: "LOGIN_WELCOME_TEXT", defaultValue: "Welcome!", comment: "The welcome text for login"))
        .onAppear {
            setDefaults()
            if Defaults[.useBiometrics] {
                biometricTask = BiometricAuthUtlity.shared.authenticate()
                    .receive(on: DispatchQueue.main)
                    .sink { _ in
                        return
                    } receiveValue: { value in
                        if value {
                            username = Defaults[.username]
                            let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)
                            password = keychain["password"] ?? ""
                            Task {
                                await login()
                            }
                        }
                    }
            }
        }
        .animation(.bouncy, value: focused)
        .alert(String(localized: "LOGIN_SAVE_CRED_QUESTION", defaultValue: "Save Credentials?", comment: "Question if the user wants to save their credentials or not"), isPresented: $showingUseBiometricsAlert) {
            Button(String(localized: "LOGIN_SAVE_CRED", defaultValue: "Save", comment: "Button to save the credentials of the user")) {
                Defaults[.useBiometrics] = true
                Defaults[.username] = username
                let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)
                keychain["password"] = password
                credentials = Credentials(username: username, password: password, districtURL: district.url)
            }
            Button(String(localized: "LOGIN_DONT_SAVE_CRED", defaultValue: "No thanks", comment: "Button to say no to saving credentials")) {
                credentials = Credentials(username: username, password: password, districtURL: district.url)
            }
        }
    }
    
    private var formValid: Bool {
        !username.isEmpty && !password.isEmpty
    }
    
    private func login() async {
        withAnimation(.easeInOut) {
            loading = true
        }
        defer {
            withAnimation(.easeInOut) {
                loading = false
            }
        }
        do {
            let credentialsToTest = Credentials(username: username, password: password, districtURL: district.url)
            let studentVue = StudentVue(credentials: credentialsToTest)
            let valid = try await studentVue.verifyCredentials()
            guard valid else {
                self.error = String(localized: "LOGIN_WRONG_CRED", defaultValue: "Invalid Username or Password", comment: "The user has entered invalid credentials")
                return
            }
            guard Defaults[.firstLogin] && !Defaults[.useBiometrics] else {
                Defaults[.firstLogin] = false
                credentials = credentialsToTest
                return
            }
            Defaults[.firstLogin] = false
            let loginRight = LARight(requirement: .biometry(fallback: .devicePasscode))
            do {
                try await loginRight.checkCanAuthorize()
                showingUseBiometricsAlert = true
                return
            } catch {
                credentials = credentialsToTest
                return
            }
        } catch {
            self.error = error.localizedDescription
            return
        }
    }
    
    private func setDefaults() {
        if Defaults[.district]?.url != district.url {
            Defaults[.useBiometrics] = false
            Defaults[.username] = ""
            let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)
            keychain["password"] = nil
            Defaults[.firstLogin] = true
        }
        Defaults[.district] = district
        var recentDistricts = Defaults[.recentDistricts]
        if let index = recentDistricts.firstIndex(where: { $0.name == district.name }) {
            recentDistricts.remove(at: index)
        }
        recentDistricts.insert(district, at: 0)
        Defaults[.recentDistricts] = Array(recentDistricts.prefix(3))
    }
}

#Preview("LoginView") {
    NavigationStack {
        LoginView(district: DistrictInfo.preview, credentials: .constant(nil), path: .constant([]))
    }
}
