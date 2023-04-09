//
//  Athlete.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 10/04/2023.
//

import Foundation

struct Athlete: Codable {
    
    let athleteId: String?
    let name: String?
    let surname: String?
    let dateOfBirth: String?
    let bio: String?
    let weight: Int?
    let height: Int?
    let photoId: Int?

    enum CodingKeys: String, CodingKey {
        case athleteId = "athlete_id"
        case photoId = "photo_id"
        case name, surname, dateOfBirth, bio, weight, height
    }

}

extension Athlete {
    
    static var dummyData: [Athlete] {
        let json = """
        [{"athlete_id":"1","name":"Arianna","surname":"Fontana","dateOfBirth":"14/04/1990","bio":"Arianna Fontana OMRI (born April 14, 1990) is an Italian short track speed skater","weight":63,"height":164,"photo_id":1},
        {"athlete_id":"2","name":"Najeeb","surname":"Fontana","dateOfBirth":"14/04/1990","bio":"Arianna Fontana OMRI (born April 14, 1990) is an Italian short track speed skater","weight":63,"height":164,"photo_id":1}
        ]
        """
        var athletes = try? JSONDecoder().decode([Athlete].self, from: json.data(using: .utf8)!)
        return athletes ?? []
    }
}
