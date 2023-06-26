//
//  View.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/14/23.
//

import SwiftUI

extension View {
    func withLogout(_ action: LogoutAction) -> some View {
        self.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    action()
                } label: {
                    Text("Log Out")
                }
                .tint(.red)
                .buttonStyle(.bordered)
                
            }
        }
    }
}
