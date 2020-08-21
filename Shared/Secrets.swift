//
//  Secrets.swift
//  ProjectS
//
//  Created by Rizwan on 21/08/20.
//

import Foundation

struct FigmaSecrets {
    static let clientId: String = ""
    static let clientSecret: String = ""
    static let authorizeUrl: String = "https://www.figma.com/oauth"
    static let accessTokenUrl: String = "https://www.figma.com/api/oauth/token"
    static let callbackUrl: String = "projects://oauth-callback"
    static let scope: String = "file_read"
    static let state: String = generateState(withLength: 20)
}

public func generateState(withLength len: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let length = UInt32(letters.count)

    var randomString = ""
    for _ in 0..<len {
        let rand = arc4random_uniform(length)
        let idx = letters.index(letters.startIndex, offsetBy: Int(rand))
        let letter = letters[idx]
        randomString += String(letter)
    }
    return randomString
}
