//
//  AthletesService.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 11/04/2023.
//

import Foundation

protocol AthletesServiceType {
    func getAthleteForId(_ id: String, completion: @escaping (Result<Athlete, NetworkError>) -> (Void))
    func getResultsForAthleteId(_ id: String, completion: @escaping (Result<[AthleteGameResult], NetworkError>) -> Void)
}

class AthletesService: BaseService, AthletesServiceType {
    
    override init(baseUrl: URL, client: NetworkClient) {
        super.init(baseUrl: URL(string: "athletes", relativeTo: baseUrl)! , client: client)
    }
    
    func getAthleteForId(_ id: String, completion: @escaping (Result<Athlete, NetworkError>) -> (Void)) {
        let endpoint = APIEndpoint<String>(url: baseUrl, method: .get, path: "\(id)")
        client.request(route: endpoint, completion)
    }
    
    func getResultsForAthleteId(_ id: String, completion: @escaping (Result<[AthleteGameResult], NetworkError>) -> Void) {
        let endpoint = APIEndpoint<String>(url: baseUrl, method: .get, path: "\(id)/results")
        client.request(route: endpoint, completion)
    }
    
}
