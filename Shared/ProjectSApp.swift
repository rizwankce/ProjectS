//
//  ProjectSApp.swift
//  Shared
//
//  Created by Rizwan on 21/08/20.
//

import SwiftUI
import OAuthSwift

@main
struct ProjectSApp: App {
    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    #endif

    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    #endif

    @AppStorage("isFigmaConnected0") var isFigmaConnected: Bool = false
    @StateObject private var defaults = AppDefaults.shared

    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            ColorsView(defaults: defaults)
                .onOpenURL { (url) in
                    if url.host == "oauth-callback" {
                        OAuthSwift.handle(url: url)
                    }
                }
            #endif

            #if os(macOS)
            ColorsView(defaults: defaults)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            #endif
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
