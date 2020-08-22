//
//  SettingsView.swift
//  ProjectS
//
//  Created by Rizwan on 21/08/20.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var defaults: AppDefaults
    @State var token: String = ""

    var body: some View {
        #if os(iOS)
        NavigationView {
            contentView
                .navigationBarTitle("Settings", displayMode: .inline)
                .navigationBarItems(leading: cancelButton)
        }
        #endif

        #if os(macOS)
        contentView
        #endif
    }

    var contentView: some View {
        VStack(spacing: 20) {
            if !defaults.isFigmaConnected {
                Button("Connect With Figma", action: onTapFigmaLogin)
                Text("OR")
                HStack {
                    TextField("Personal Access Token", text: $token)
                    Button("Save", action: {
                        defaults.token = token
                        defaults.isFigmaConnected = true
                    })
                }
            }
            else {
                Button("Disconnect with Figma", action: onTapDisconnectFigma)
            }
        }
        .padding()
    }

    var cancelButton: some View {
        Button.init(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Cancel")
        })
    }

    func onTapDisconnectFigma() {
        defaults.isFigmaConnected = false
        defaults.token = ""
    }

    func onTapFigmaLogin() {
        FigmaClient.shared.authroize { (result) in
            switch result {
            case .success( _):
                print("login success")
                defaults.isFigmaConnected = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(defaults: AppDefaults.shared)
    }
}
