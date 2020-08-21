//
//  SettingsView.swift
//  ProjectS
//
//  Created by Rizwan on 21/08/20.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var defaults: AppDefaults

    @State var token: String = ""

    var body: some View {
        VStack {
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
    }

    func onTapDisconnectFigma() {
        defaults.isFigmaConnected = false
        defaults.token = ""
    }

    func onTapFigmaLogin() {
        FigmaClient.shared.authroize { (result) in
            switch result {
            case .success(let _):
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
