//
//  Game.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 10/04/2023.
//

import Foundation

struct Game: Codable {
    
    let gameId: Int?
    let city: String?
    let year: Int?
    
    enum CodingKeys: String, CodingKey {
        case gameId = "game_id"
        case city, year
    }
}

extension Game {
    
    static var dummyData: [Game] {
        var json = """
        [{"game_id":1,"city":"Tokyo","year":2020},{"game_id":2,"city":"Rio de Janeiro","year":2016},{"game_id":3,"city":"London","year":2012},{"game_id":4,"city":"Pyeongchang","year":2018},{"game_id":5,"city":"Sochi","year":2014},{"game_id":6,"city":"Vancouver","year":2010},{"game_id":7,"city":"Turin","year":2006},{"game_id":8,"city":"Beijing","year":2008},{"game_id":9,"city":"Athens","year":2004},{"game_id":10,"city":"Salt Lake City","year":2002},{"game_id":11,"city":"Sydney","year":2000},{"game_id":12,"city":"Nagano","year":1998},{"game_id":13,"city":"Atlanta","year":1996},{"game_id":14,"city":"Barcelona","year":1992},{"game_id":15,"city":"Seoul","year":1988},{"game_id":16,"city":"Los Angeles","year":1984}]
        """
        let games = try? JSONDecoder().decode([Game].self, from: json.data(using: .utf8)!)
        return games ?? []
    }
    
}