//
//  NetworkConstants.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-21.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation

struct NetworkConstants {
    static let Domain = "api.doitserver.in.ua"
    static let BasePath = "http://\(NetworkConstants.Domain)"
    static let ApiPath = ""
    static let VersionPath = ""
    static let BaseUrl: URL = URL(string: "\(NetworkConstants.BasePath)\(NetworkConstants.ApiPath)\(NetworkConstants.VersionPath)")!
}

// MARK: MessageType

enum NetworkError: Error {
    case success
    case wrong
    case imageToSmall
    case badInput
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .success:
            return NSLocalizedString("Success", comment: "")
        case .wrong, .badInput:
            return NSLocalizedString("Something went wrong", comment: "")
        case .imageToSmall:
            return NSLocalizedString("Image to small", comment: "")
        }
    }
    
}
