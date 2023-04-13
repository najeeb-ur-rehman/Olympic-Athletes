//
//  Environment.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 11/04/2023.
//

import Foundation

enum Environment {
    case development
    case production
    
    var baseUrl: URL {
        switch self {
        case .development:
            return URL(string: "https://ocs-test-backend.onrender.com/")!
        case .production:
            return URL(string: "https://ocs-test-backend.onrender.com/")!
        }
    }
}

extension Environment {
    static var current: Environment = .production
}

