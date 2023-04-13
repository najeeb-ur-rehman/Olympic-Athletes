//
//  GamesService.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 11/04/2023.
//

import Foundation

protocol GamesServiceType {
    func getGamesWithCompletion(_ completion: @escaping (Result<[Game], NetworkError>) -> Void)
    func getAthletesForGameId(_ id: Int, completion: @escaping (Result<[Athlete], NetworkError>) -> Void)
}

class GamesService: BaseService, GamesServiceType {
    
    override init(baseUrl: URL, client: NetworkClient) {
        super.init(baseUrl: URL(string: "games", relativeTo: baseUrl)! , client: client)
    }
    
    func getGamesWithCompletion(_ completion: @escaping (Result<[Game], NetworkError>) -> Void) {
        let endpoint = APIEndpoint<String>(url: baseUrl, method: .get, path: "")
        client.request(route: endpoint, completion)
    }
    
    func getAthletesForGameId(_ id: Int, completion: @escaping (Result<[Athlete], NetworkError>) -> Void) {
        let endpoint = APIEndpoint<String>(url: baseUrl, method: .get, path: "\(id)/athletes")
        client.request(route: endpoint, completion)
        
    }
}
