//
//  ProjectSApp.swift
//  Shared
//
//  Created by Rizwan on 21/08/20.
//

import SwiftUI

@main
struct ProjectSApp: App {
    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    #endif
    @AppStorage("isFigmaConnected0") var isFigmaConnected: Bool = false
    @StateObject private var defaults = AppDefaults.shared

    var body: some Scene {
        WindowGroup {
            ColorsView(defaults: defaults)
        }
        #if os(macOS)
        Settings {
            TabView {
                SettingsView(defaults: defaults)
                    .tabItem {
                        Image(systemName: "at")
                            .font(.title2)
                        Text("Accounts")
                    }
            }
            .frame(width: 500)
            .padding()
        }
        #endif
    }
}
