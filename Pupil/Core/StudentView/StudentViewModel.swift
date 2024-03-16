//
//  StudentViewModel.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/19/23.
//

import Foundation
import SwiftVue

class StudentViewModel: ObservableObject {
    @Published var studentInfo: StudentInfo?
    @Published var loading: Bool = false
    @Published var error: Error?
    private let credentials: Credentials
    
    init(_ credentials: Credentials) {
        self.credentials = credentials
    }
    
    private var studentVue: StudentVue {
        return StudentVue(credentials: credentials)
    }
    
    @MainActor
    func loadData() async {
        loading = true
        await getStudentInfo()
        loading = false
    }
    
    @MainActor
    func refresh() async {
        if !loading {
            await getStudentInfo()
        }
    }
    
    @MainActor
    private func getStudentInfo() async {
        studentInfo = nil
        do {
            let result = try await studentVue.getStudentInfo()
            studentInfo = result
            error = nil
        } catch {
            self.error = error
            return
        }
    }
}
