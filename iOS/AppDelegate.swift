//
//  AppDelegate.swift
//  ProjectS
//
//  Created by Rizwan on 22/08/20.
//

import UIKit
import OAuthSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication) {

    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.host == "projects" {
            OAuthSwift.handle(url: url)
        }
        return true
    }
}


