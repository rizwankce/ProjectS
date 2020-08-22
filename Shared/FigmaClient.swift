//
//  FigmaClient.swift
//  ProjectS
//
//  Created by Rizwan on 21/08/20.
//

import Foundation
import OAuthSwift

public typealias TokenCompletionHandler = (Result<Bool, OAuthSwiftError>) -> Void
public typealias CompletionHandler = (_ result: Result<OAuthSwiftResponse, OAuthSwiftError>) -> Void

final class FigmaClient {
    let oauthswift: OAuth2Swift

    static let shared: FigmaClient = FigmaClient()

    init() {
        self.oauthswift = OAuth2Swift(
            consumerKey: FigmaSecrets.clientId,
            consumerSecret: FigmaSecrets.clientSecret,
            authorizeUrl: FigmaSecrets.authorizeUrl,
            accessTokenUrl: FigmaSecrets.accessTokenUrl,
            responseType: "code"
        )
        self.oauthswift.authorizeURLHandler = OAuthSwiftOpenURLExternally.sharedInstance
    }

    func authroize(_ completion: @escaping TokenCompletionHandler) {
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: FigmaSecrets.callbackUrl)!,
            scope: FigmaSecrets.scope,
            state: FigmaSecrets.state
        ) { result in
            switch result {
            case .success( (_, _, _)):
                completion(.success(true))
                //self.getFile("wxc1NIgZj8FXeJmWTZhJCu")
            case .failure(let error):
                print(error.description)
                completion(.failure(error))
            }
        }
    }

    func getFile(_ key: String, _ completion: @escaping CompletionHandler) {
        var headers: [String: String] = [:]
        if !AppDefaults.shared.token.isEmpty {
            headers["X-Figma-Token"] = AppDefaults.shared.token
        }
        oauthswift.client.request("https://api.figma.com/v1/files/"+key, method: .GET, parameters: [:], headers: headers, completionHandler: completion)
        //oauthswift.client.get("https://api.figma.com/v1/files/"+key, completionHandler: completion)
    }
}

