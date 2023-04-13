//
//  BaseService.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 11/04/2023.
//

import Foundation

class BaseService {
    
    let baseUrl: URL
    let client: NetworkClient
    
    init(baseUrl: URL, client: NetworkClient) {
        self.baseUrl = baseUrl
        self.client = client
    }
}
