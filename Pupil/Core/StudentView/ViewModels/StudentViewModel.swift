//
//  StudentViewModel.swift
//  Pupil
//
//  Created by Evan Kaneshige on 2/19/23.
//

import Foundation
import SwiftVue

class StudentViewModel: ObservableObject {
    let studentVue: StudentVue
    
    @Published var studentInfo: StudentInfo?
    @Published var loading: Bool = false
    
    @Published var error: String?
    
    init(credentials: Credentials, isPreview: Bool = false) {
        self.studentVue = StudentVue(credentials: credentials)
        if isPreview {
            self.studentInfo = PreviewData.instance.studentInfo
        }
    }
    
    @MainActor
    func loadData() async {
        loading = true
        await getStudentInfo()
        loading = false
    }
    
    func refresh() {
        Task {
            await loadData()
        }
    }
    
    @MainActor
    private func getStudentInfo() async {
        studentInfo = nil
        let result = await studentVue.getStudentInfo()
        switch result {
        case .success(let success):
            studentInfo = success
            error = nil
        case .failure(let err):
            error = err.localizedDescription
            return
        }
    }
}
