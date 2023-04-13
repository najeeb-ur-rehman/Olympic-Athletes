//
//  NetworkError.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 11/04/2023.
//

import Foundation

public enum NetworkError: LocalizedError {
    case badRequest
    case unknown
    case serverError(Error)
    case decoding(Error)
    case custom(String)
}
