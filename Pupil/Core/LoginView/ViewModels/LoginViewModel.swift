//
//  LoginViewModel.swift
//  Pupil
//
//  Created by Evan Kaneshige on 12/5/22.
//

import Foundation
import SwiftVue
import LocalAuthentication
import Combine
import Defaults
import WidgetKit
import KeychainAccess

class LoginViewModel: ObservableObject {
    @Published var loggedIn: Bool = false
    @Published var showDistrictPicker: Bool = false
    @Published var district: DistrictInfo? = Defaults[.district]
    
    @Published var zipCode: String = ""
    @Published var districts: [DistrictInfo] = []
    @Published var loading: Bool = false
    @Published var error: String?
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var formValid: Bool = false
    
    init() {
        $zipCode
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .removeDuplicates()
            .handleEvents(receiveOutput: { _ in
                self.loading = true
            })
            .flatMap { zip in
                Future { promise in
                    Task {
                        let result = await self.getDistricts(zipCode: zip)
                        promise(result)
                    }
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .handleEvents(receiveOutput: { _ in
                self.loading = false
            })
            .assign(to: &$districts)
        
        $username
            .combineLatest($password)
            .combineLatest($district)
            .map { info in
                return !info.0.0.isEmpty && !info.0.1.isEmpty && info.1 != nil
            }
            .assign(to: &$formValid)
    }
    
    private func getDistricts(zipCode: String) async -> Result<[DistrictInfo], Never> {
        guard zipCode.count >= 3, zipCode.count <= 5, let zip = Int(zipCode) else { return .success([]) }
        let result = await StudentVue.getDistrictList(zip: zip)
        switch result {
        case .success(let success):
            return .success(success.districtInfos)
        case .failure(_):
            return .success([])
        }
    }
    
    @MainActor
    func login() async {
        Defaults[.district] = district
        loading = true
        let result = await StudentVue.verifyCredentials(Credentials(username: username, password: password, districtURL: district?.url ?? ""))
        switch result {
        case .success(let valid):
            if !valid {
                error = "Invalid Username or Password"
            } else {
                error = nil
                if Defaults[.useBiometrics] {
                    Defaults[.username] = username
                    let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)
                    keychain["password"] = password
                }
            }
            loggedIn = valid
        case .failure(let error):
            loggedIn = false
            self.error = error.localizedDescription
        }
        loading = false
        
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    @MainActor
    func logout() {
        password = ""
        username = ""
        error = nil
        loading = false
        loggedIn = false
    }
    
    @MainActor
    func loadCredentials() {
        DispatchQueue.main.async { [weak self] in
            let keychain = Keychain(service: Keychain_Credential_Service, accessGroup: Keychain_Group).accessibility(.afterFirstUnlock)
            self?.username = Defaults[.username]
            self?.password = keychain["password"] ?? ""
        }
    }
    
    func getBiometricType() -> String? {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            switch context.biometryType {
            case .faceID: return "faceid"
            case .touchID: return "touchid"
            case .none: return nil
            @unknown default: return nil
            }
        }
        return nil
    }
}
