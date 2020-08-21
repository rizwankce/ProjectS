//
//  AppDefaults.swift
//  ProjectS
//
//  Created by Rizwan on 21/08/20.
//

import Foundation
import SwiftUI

final class AppDefaults: ObservableObject {
    public static let shared = AppDefaults()

    @AppStorage(wrappedValue: false, "figmaConnected008", store: UserDefaults.standard) var isFigmaConnected: Bool {
        didSet {
            objectWillChange.send()
        }
    }

    @AppStorage(wrappedValue: "", "token", store: UserDefaults.standard) var token: String {
        didSet {
            objectWillChange.send()
        }
    }
}
