//
//  MenuButtons.swift
//  Pupil
//
//  Created by Evan Kaneshige on 10/27/23.
//

import SwiftUI
import WidgetKit

struct GiveAliasButton: View {
    @Binding var showingSheet: Bool
    var body: some View {
        Button {
            showingSheet = true
        } label: {
            Label(String(localized: "GIVE_ALIAS_BUTTON", defaultValue: "Give alias", comment: "Button to show the alias picker and give an alias"), systemImage: "pencil")
        }
    }
}

struct RemoveAliasLinkButton: View {
    @Environment(\.modelContext) private var context
    var link: AliasLink
    var body: some View {
        Button(role: .destructive) {
            context.delete(link)
            WidgetCenter.shared.reloadAllTimelines()
        } label: {
            Label(String(localized: "REMOVE_ALIAS_BUTTON", defaultValue: "Remove Alias", comment: "Button to remove an alias"), systemImage: "trash")
        }
    }
}

struct CopyEmailButton: View {
    var email: String
    var body: some View {
        Button {
            UIPasteboard.general.string = email
        } label: {
            Label(String(localized: "COPY_EMAIL_BUTTON", defaultValue: "Copy Email", comment: "Button to copy an email address"), systemImage: "doc.on.doc")
        }
    }
}

struct ComposeEmailButton: View {
    var url: URL
    var body: some View {
        Link(destination: url) {
            Label(String(localized: "COMPOSE_EMAIL_BUTTON", defaultValue: "Compose Email", comment: "Button to compose an email"), systemImage: "envelope")
        }
    }
}

struct EmailButtons: View {
    var email: String
    var body: some View {
        if email.count > 0 {
            CopyEmailButton(email: email)
            
            if let emailURL = URL(string: "mailto:" + email.lowercased()) {
                ComposeEmailButton(url: emailURL)
                
            }
        }
    }
}
